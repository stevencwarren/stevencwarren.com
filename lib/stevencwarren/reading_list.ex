defmodule Stevencwarren.ReadingList do
  @moduledoc """

    ReadingList Context that is responsible for showing categories
    and their related articles
  """

  import Ecto.Query
  alias Stevencwarren.ReadingList.Article
  alias Stevencwarren.ReadingList.ArticleParser
  alias Stevencwarren.ReadingList.Category
  alias Stevencwarren.Repo

  def article_changeset do
    Article.changeset(%Article{}, %{})
  end

  def category_changeset(%Category{} = category) do
    Category.changeset(category, %{})
  end

  def create_article(attrs \\ %{}) do
    changeset = Article.changeset(%Article{}, attrs)

    Repo.insert(changeset)
  end

  def create_category(params) do
    changeset = Category.changeset(%Category{}, params)

    Repo.insert(changeset)
  end

  def get_article!(id), do: Repo.get!(Article, id)

  def get_category!(slug) do
    from(c in Category, where: c.slug == ^slug)
    |> Repo.one!()
    |> Repo.preload([:articles])
  end

  def list_categories do
    Category |> order_by(asc: :name) |> Repo.all()
  end

  def mark_article_read!(article) do
    article
    |> Article.changeset(%{read: true})
    |> Repo.update()
  end

  def update_article_description(article) do
    attrs = ArticleParser.get_title_and_description(article.url)

    article
    |> Article.changeset(attrs)
    |> Repo.update()
  end

  def update_category(category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end

  def recent_articles do
    Repo.all(
      from a in Article,
        where: a.read == false,
        order_by: [desc: :inserted_at],
        limit: 5,
        preload: [:category]
    )
  end
end
