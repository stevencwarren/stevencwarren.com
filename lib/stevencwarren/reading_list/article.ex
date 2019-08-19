defmodule Stevencwarren.ReadingList.Article do
  @moduledoc """
    The Article module keeps track of Articles from the web.
  """

  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]
  use Ecto.Schema

  alias Stevencwarren.ReadingList.Article
  alias Stevencwarren.ReadingList.Category

  schema "articles" do
    field :description, :string
    field :read, :boolean, default: false
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

    slug =
      query
      |> Stevencwarren.Repo.aggregate(:count, :id)
      |> generate_slug(title)

    change(changeset, slug: Slugger.slugify_downcase(slug))
  end

  defp slugify(changeset), do: changeset

  defp generate_slug(0, title), do: title

  defp generate_slug(count, title) do
    "#{title}-#{count}"
  end
end
