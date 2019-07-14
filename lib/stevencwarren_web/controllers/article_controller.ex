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

  def create(conn, %{"article" => article_params}) do
    case ReadingList.create_article(article_params) do
      {:ok, article } ->
        conn
        |> redirect(to: Routes.article_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset } ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
