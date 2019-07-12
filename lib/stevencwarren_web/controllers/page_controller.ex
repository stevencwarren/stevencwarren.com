defmodule StevencwarrenWeb.PageController do
  use StevencwarrenWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
