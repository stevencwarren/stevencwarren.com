defmodule Stevencwarren.ReadingList do
  alias Stevencwarren.Repo
  alias Stevencwarren.ReadingList.Category

  def create_category(name) do
    changeset = Category.changeset(%Category{}, %{name: name})

    Repo.insert(changeset)
  end
end
