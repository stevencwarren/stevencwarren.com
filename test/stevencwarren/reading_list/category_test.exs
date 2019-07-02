defmodule Stevencwarren.ReadingList.CategoryTest do
  use Stevencwarren.DataCase
  alias Stevencwarren.ReadingList.Category

  describe "changesets" do
    test "validates that name is required" do
      changeset = Category.changeset(%Category{}, %{})

      refute changeset.valid?
    end

    test "the category changeset generates the slug from the name" do
      changeset = Category.changeset(%Category{}, %{
        name: "Foo Name!!!",
      })

      {:ok, category} = Stevencwarren.Repo.insert(changeset)

      assert category.slug == "foo-name"
    end

    test "the category changeset creates a unique slugs" do
      Stevencwarren.Repo.insert(Category.changeset(%Category{}, %{
        name: "Foo Name"
      }))

      Stevencwarren.Repo.insert(Category.changeset(%Category{}, %{
        name: "Foo Name"
      }))

      changeset = Category.changeset(%Category{}, %{
        name: "Foo Name"
      })

      {:ok, dup} = Stevencwarren.Repo.insert(changeset)

      assert dup.slug == "foo-name-2"
    end
  end
end
