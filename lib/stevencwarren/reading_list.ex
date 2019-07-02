defmodule Stevencwarren.ReadingList do
  alias Stevencwarren.Repo
  alias Stevencwarren.ReadingList.Category
  import Ecto.Query

  def create_category(name) do
    changeset = Category.changeset(%Category{}, %{name: name})

    Repo.insert(changeset)
  end

  def list_categories do
    order_by(Category, asc: :name) |> Repo.all()
  end
end
