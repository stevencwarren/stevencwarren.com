defmodule StevencwarrenWeb.CategoryController do
  use StevencwarrenWeb, :controller

  alias Stevencwarren.ReadingList

  def show(conn, %{"id" => slug}) do
    {:ok, category} = ReadingList.get_category!(slug)

    render(conn, "show.html", category: category)
  end
end
