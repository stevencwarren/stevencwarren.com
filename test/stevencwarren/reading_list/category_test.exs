defmodule Stevencwarren.ReadingList.CategoryTest do
  use Stevencwarren.DataCase
  alias Stevencwarren.ReadingList.Category
  import Stevencwarren.Factory

  describe "changesets" do
    test "validates that name is required" do
      changeset = Category.changeset(%Category{}, %{})

      refute changeset.valid?
    end

    test "categories validate that names are unique" do
      insert(:category, %{ name: "foo" })

      changeset = Category.changeset(%Category{}, %{name: "foo"})
      { :error, changeset} = Repo.insert(changeset)

      assert changeset.errors != nil
    end


    test "the category changeset generates the slug from the name" do
      changeset = Category.changeset(%Category{}, %{
        name: "Foo Name!!!",
      })

      {:ok, category} = Stevencwarren.Repo.insert(changeset)

      assert category.slug == "foo-name"
    end
  end
end
