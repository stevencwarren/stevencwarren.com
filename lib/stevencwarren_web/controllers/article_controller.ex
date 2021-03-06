defmodule StevencwarrenWeb.ArticleController do
  use StevencwarrenWeb, :controller

  alias Stevencwarren.ReadingList
  alias Stevencwarren.UserManager.Guardian

  def index(conn, _) do
    categories = ReadingList.list_categories()
    recent_articles = ReadingList.recent_articles()
    user = Guardian.Plug.current_resource(conn)

    render(conn, "index.html",
      categories: categories,
      recent_articles: recent_articles,
      user: user
    )
  end

  def new(conn, _) do
    categories = ReadingList.list_categories()
    user = Guardian.Plug.current_resource(conn)

    render(conn, "new.html",
      categories: categories,
      changeset: ReadingList.article_changeset(),
      user: user
    )
  end

  def create(conn, %{"article" => article_params}) do
    case ReadingList.create_article(article_params) do
      {:ok, article} ->
        Task.async(ReadingList, :update_article_description, [article])

        conn
        |> redirect(to: Routes.article_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def mark_read(conn, %{"article_id" => article_id}) do
    article = ReadingList.get_article!(article_id)

    ReadingList.mark_article_read!(article)

    conn
    |> put_flash(:info, "You have marked the article as read")
    |> redirect(to: "/reading-list")
  end
end
