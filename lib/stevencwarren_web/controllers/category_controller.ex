defmodule StevencwarrenWeb.CategoryController do
  use StevencwarrenWeb, :controller

  alias Stevencwarren.ReadingList

  def show(conn, %{"id" => slug}) do
    categories = ReadingList.list_categories()
    {:ok, category} = ReadingList.get_category!(slug)

    render(conn, "show.html", category: category, categories: categories)
  end
end
