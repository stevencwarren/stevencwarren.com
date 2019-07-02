defmodule Stevencwarren.ReadingListTest do
  use Stevencwarren.DataCase

  alias Stevencwarren.Repo
  import Stevencwarren.Factory

  alias Stevencwarren.ReadingList
  alias Stevencwarren.ReadingList.Article
  alias Stevencwarren.ReadingList.Category

  describe "articles" do
  end

  describe "create_category/1" do
    test "it creates a category from the supplied params" do
      {:ok, category} = ReadingList.create_category("test category")

      assert category.name == "test category"
      assert Repo.aggregate(Category, :count, :id) == 1
    end
  end

  describe "list_categories/0" do
    test "it returns all of the categories in alphabetical order" do
      category_Z = insert(:category, %{name: "Z category" })
      category_B = insert(:category, %{name: "B category" })
      category_A = insert(:category, %{name: "A category" })
      category_Y = insert(:category, %{name: "Y category" })

      categories = ReadingList.list_categories

      assert categories == [category_A, category_B, category_Y, category_Z]
    end
  end
end
