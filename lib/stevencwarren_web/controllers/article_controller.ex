defmodule StevencwarrenWeb.ArticleController  do
  use StevencwarrenWeb, :controller

  alias Stevencwarren.ReadingList

  def index(conn, _) do
    categories = ReadingList.list_categories
    render(conn, "index.html", categories: categories)
  end
end
