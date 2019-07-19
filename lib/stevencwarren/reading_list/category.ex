defmodule Stevencwarren.ReadingList.Category do
  @moduledoc """
    This is the module for the ReadingList.Category

    Categories are used to organize Articles
  """

  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  alias Stevencwarren.ReadingList.Article
  alias Stevencwarren.ReadingList.Category

  schema "categories" do
    field :name, :string
    field :slug, :string
    has_many :articles, Article

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name])
    |> validate_required(:name)
    |> unique_constraint(:name)
    |> slugify
  end

  defp slugify(%Ecto.Changeset{valid?: true, changes: %{name: name}} = changeset) do
    query = from a in Category, where: a.name == ^name

    slug =
      query
      |> Stevencwarren.Repo.aggregate(:count, :id)
      |> generate_slug(name)

    change(changeset, slug: Slugger.slugify_downcase(slug))
  end

  defp slugify(changeset), do: changeset

  defp generate_slug(0, name), do: name

  defp generate_slug(count, name) do
    "#{name}-#{count}"
  end
end
