defmodule Stevencwarren.ReadingListTest do
  use Stevencwarren.DataCase

  alias Stevencwarren.Repo
  import Stevencwarren.Factory

  alias Stevencwarren.ReadingList
  alias Stevencwarren.ReadingList.Article
  alias Stevencwarren.ReadingList.Category

  describe "article_changeset/0" do
    test "it returns an empty changeset" do
      assert Article.changeset(%Article{}, %{}) == ReadingList.article_changeset
    end
  end

  describe "create_article/1" do
    test "it creates a category when it is given valid params" do
      category = insert(:category)
      { :ok, article } = ReadingList.create_article(%{url: "http://foo.com", category_id: category.id })

      assert article.url == "http://foo.com"
      assert article.category_id == category.id
    end

    test "it returns an error if there is no url" do
      category = insert(:category)
      { :error, message}  = ReadingList.create_article(%{category_id: category.id })

      assert message == "You must include a url and a category"
    end
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
