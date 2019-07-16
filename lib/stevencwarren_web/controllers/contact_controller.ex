defmodule StevencwarrenWeb.ContactController do
  use StevencwarrenWeb, :controller

  def new(conn, _) do
    render(conn, "new.html")
  end
end
