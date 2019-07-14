defmodule StevencwarrenWeb.ArticleController  do
  use StevencwarrenWeb, :controller

  alias Stevencwarren.ReadingList

  def index(conn, _) do
    categories = ReadingList.list_categories
    render(conn, "index.html", categories: categories)
  end

  def new(conn, _) do
    categories = ReadingList.list_categories
    render(conn, "new.html", categories: categories, changeset: ReadingList.article_changeset)
  end
end
