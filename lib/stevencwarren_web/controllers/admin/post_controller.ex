defmodule StevencwarrenWeb.Admin.PostController do
  use StevencwarrenWeb, :controller

  alias Stevencwarren.Repo

  def index(conn, _params) do
    render(conn, "index.html", posts: Stevencwarren.Blog.list_posts())
  end
end
