defmodule StevencwarrenWeb.Router do
  use StevencwarrenWeb, :router

  pipeline :auth do
    plug Stevencwarren.UserManager.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", StevencwarrenWeb do
    pipe_through [:browser, :auth]

    get "/", PageController, :index

    get "/health", PageController, :health

    get "/projects", PageController, :projects

    get "/login", SessionController, :new
    post "/login", SessionController, :login
    post "/logout", SessionController, :logout

    resources "/reading-list", ArticleController, only: [:index]
    resources "/categories", CategoryController, only: [:show]
    resources "/contact", ContactController, only: [:index, :create]
  end

  scope "/", StevencwarrenWeb do
    pipe_through [:browser, :auth, :ensure_auth]

    resources "/reading-list", ArticleController, only: [:new, :create] do
      get "/mark-read", ArticleController, :mark_read
    end
  end

  if Mix.env() == :dev do
    forward "/sent_emails", Bamboo.SentEmailViewerPlug
  end

  # Other scopes may use custom stacks.
  scope "/admin", StevencwarrenWeb.Admin, as: :admin, alias: Admin do
    pipe_through [:browser, :auth, :ensure_auth]

    get "/dashboard", DashboardController, :index
  end
end
