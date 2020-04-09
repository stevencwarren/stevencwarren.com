defmodule Stevencwarren.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :body, :string
    field :published_on, :date
    field :tags, {:array, :string}
    field :title, :string

    belongs_to :category, Stevencwarren.ReadingList.Category

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:category_id, :title, :body, :published_on, :tags])
    |> validate_required([:title, :body, :published_on, :tags])
  end
end
