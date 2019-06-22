defmodule StevencwarrenWeb.SessionController do
  use StevencwarrenWeb, :controller

  alias Stevencwarren.{UserManager, UserManager.User, UserManager.Guardian}

  def new(conn, _) do
    changeset = UserManager.change_user(%User{})
    maybe_user = Guardian.Plug.current_resource(conn)
    if maybe_user do
      redirect(conn, to: "/admin/dashboard")
    else
      render(conn, "new.html", changeset: changeset, action: StevencwarrenWeb.Router.Helpers.session_path(conn, :login))
    end
  end

  def login(conn, %{"user" => %{"email" => email, "password" => password}}) do
    UserManager.authenticate_user(email, password)
    |> login_reply(conn)
  end

  def logout(conn, _) do
    conn
    |> Guardian.plug.sign_out()
    |> redirect(to: "/login")
  end

  defp login_reply({:ok, user}, conn) do
    conn
    |> put_flash(:success, "You are authenticated as #{user.email}")
    |> Guardian.Plug.sign_in(user)
    |> redirect(to: StevencwarrenWeb.Router.Helpers.admin_dashboard_path(conn, :index))
  end

  defp login_reply({:error, reason}, conn) do
    conn
    |> put_flash(:error, to_string(reason))
    |> new(%{})
  end
end
