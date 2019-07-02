defmodule Stevencwarren.ReadingListTest do
  use Stevencwarren.DataCase

  alias Stevencwarren.Repo
  alias Stevencwarren.ReadingList
  alias Stevencwarren.ReadingList.Article
  alias Stevencwarren.ReadingList.Category

  describe "articles" do
  end

  describe "create_category" do
    test "it creates a category from the supplied params" do
      {:ok, category} = ReadingList.create_category("test category")

      assert category.name == "test category"
      assert Repo.aggregate(Category, :count, :id) == 1
    end
  end
end
