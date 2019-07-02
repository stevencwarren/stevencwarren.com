defmodule Stevencwarren.ReadingList.Category do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  alias Stevencwarren.ReadingList.Category

  schema "categories" do
    field :name, :string
    field :slug, :string

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name])
    |> validate_required(:name)
    |> slugify
  end

  defp slugify(%Ecto.Changeset{valid?: true, changes: %{name: name}} = changeset) do
    query = from a in Category, where: a.name == ^name

    slug = Stevencwarren.Repo.aggregate(query, :count, :id)
      |> generate_slug(name)
    change(changeset, slug: Slugger.slugify_downcase(slug))
  end

  defp slugify(changeset), do: changeset

  defp generate_slug(0, name), do: name

  defp generate_slug(count, name) do
    "#{name}-#{count}"
  end
end
