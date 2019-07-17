defmodule Stevencwarren.ReadingList.Article do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  alias Stevencwarren.ReadingList.Article
  alias Stevencwarren.ReadingList.Category

  schema "articles" do
    field :description, :string
    field :read, :boolean
    field :slug, :string
    field :title, :string
    field :url, :string
    belongs_to :category, Category

    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:category_id, :title, :description, :url, :read])
    |> validate_required([:url])
    |> slugify
  end

  defp slugify(%Ecto.Changeset{valid?: true, changes: %{title: title}} = changeset) do
    query = from a in Article, where: a.title == ^title

    slug = Stevencwarren.Repo.aggregate(query, :count, :id)
      |> generate_slug(title)
    change(changeset, slug: Slugger.slugify_downcase(slug))
  end

  defp slugify(changeset), do: changeset

  defp generate_slug(0, title), do: title

  defp generate_slug(count, title) do
    "#{title}-#{count}"
  end
end
