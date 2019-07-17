defmodule Stevencwarren.ReadingListTest do
  use Stevencwarren.DataCase
  use Timex

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

  describe "create_category/1" do
    test "it creates a category from the supplied params" do
      {:ok, category} = ReadingList.create_category("test category")

      assert category.name == "test category"
      assert Repo.aggregate(Category, :count, :id) == 1
    end
  end

  describe "get_category/1" do
    test "it returns a category when it has a correct slug" do
      category = insert(:category, %{ name: "a category", slug: "a-category" })
      {:ok, result } = ReadingList.get_category!("a-category")

      assert result.id == category.id
    end

    @tag :skip
    test "it returns an error when the slug doesn't exists" do
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

  describe "mark_article_read!/1" do
    test "when the article is found and not read it sets the article as read" do
      article = insert(:article)

      assert {:ok, article } = ReadingList.mark_article_read!(article)
      assert article.read == true
    end
  end

  describe "recent_articles/0" do
    test "it returns the 5 recently added articles" do
      article_1 = insert(:article, inserted_at: Timex.shift(Timex.now, days: -5))
      article_2 = insert(:article, inserted_at: Timex.shift(Timex.now, days: -4))
      article_3 = insert(:article, inserted_at: Timex.shift(Timex.now, days: -3))
      article_4 = insert(:article, inserted_at: Timex.shift(Timex.now, days: -2))
      article_5 = insert(:article, inserted_at: Timex.shift(Timex.now, days: -1))
      _article_6 = insert(:article, inserted_at: Timex.shift(Timex.now, days: -7))

      articles = ReadingList.recent_articles

      assert articles == [article_5, article_4, article_3, article_2, article_1]
    end
  end
end
