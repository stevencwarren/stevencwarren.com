defmodule StevencwarrenWeb.ArticleController  do
  use StevencwarrenWeb, :controller

  alias Stevencwarren.ReadingList

  def index(conn, _) do
    categories = ReadingList.list_categories
    recent_articles = ReadingList.recent_articles
    render(conn, "index.html", categories: categories, recent_articles: recent_articles)
  end

  def new(conn, _) do
    categories = ReadingList.list_categories
    render(conn, "new.html", categories: categories, changeset: ReadingList.article_changeset)
  end

  def create(conn, %{"article" => article_params}) do
    case ReadingList.create_article(article_params) do
      {:ok, _article } ->
        conn
        |> redirect(to: Routes.article_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset } ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
