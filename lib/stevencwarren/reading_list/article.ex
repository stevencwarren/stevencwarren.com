defmodule Stevencwarren.ReadingList.Article do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  alias Stevencwarren.ReadingList.Article

  schema "articles" do
    field :description, :string
    field :slug, :string
    field :title, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title, :description, :url])
    |> validate_required([:title, :url])
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
