defmodule Stevencwarren.ReadingList do
  alias Stevencwarren.Repo
  alias Stevencwarren.ReadingList.Article
  alias Stevencwarren.ReadingList.Category
  import Ecto.Query

  def article_changeset() do
    Article.changeset(%Article{}, %{})
  end

  def create_article(attrs \\ %{}) do
    changeset = Article.changeset(%Article{}, attrs)

    Repo.insert(changeset)
  end

  def create_category(name) do
    changeset = Category.changeset(%Category{}, %{name: name})

    Repo.insert(changeset)
  end

  def list_categories do
    order_by(Category, asc: :name) |> Repo.all()
  end

  def recent_articles do
    order_by(Article, desc: :inserted_at)
    |> limit(5)
    |> preload(:category)
    |> Repo.all()
  end
end