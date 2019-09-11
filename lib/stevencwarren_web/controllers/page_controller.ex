defmodule StevencwarrenWeb.PageController do
  use StevencwarrenWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def health(conn, _params) do
    render(conn, "health.html")
  end

  def projects(conn, _params) do
    render(conn, "projects.html")
  end
end
