defmodule Stevencwarren.ReadingListTest do
  use Stevencwarren.DataCase
  use Timex

  alias Stevencwarren.Repo
  import Stevencwarren.Factory
  import Ecto.Query

  alias Stevencwarren.ReadingList
  alias Stevencwarren.ReadingList.{Article, Category}

  describe "article_changeset/0" do
    test "it returns an empty changeset" do
      assert Article.changeset(%Article{}, %{}) == ReadingList.article_changeset()
    end
  end

  describe "category_changeset/1" do
    test "it returns an empty changeset" do
      assert Category.changeset(%Category{}, %{}) == ReadingList.category_changeset(%Category{})
    end
  end

  describe "create_article/1" do
    test "it creates an article with the supplied params" do
      ReadingList.create_article(%{ url: "https://stevencwarren.com"})

      last_article = Article |>last |> Repo.one

      assert last_article.url == "https://stevencwarren.com"
      assert Repo.aggregate(Article, :count, :id) == 1
    end
  end

  describe "create_category/1" do
    test "it creates a category from the supplied params" do
      ReadingList.create_category(%{ name: "test category"})

      last_category = Category |>last |> Repo.one

      assert last_category.name == "test category"
      assert Repo.aggregate(Category, :count, :id) == 1
    end
  end

  describe "get_category/1" do
    test "it returns a category when it has a correct slug" do
      category = insert(:category, %{name: "a category", slug: "a-category"})
                 |> Repo.preload(:articles)

      assert ReadingList.get_category!("a-category") == category
    end

    test "it raises a 404 when the category is not found" do
      insert(:category, %{name: "a category", slug: "a-category"})

      assert_raise Ecto.NoResultsError,  fn ->
        ReadingList.get_category!("foo")
      end
    end
  end

  describe "list_categories/0" do
    test "it returns all of the categories in alphabetical order" do
      category_z = insert(:category, %{name: "Z category"})
      category_b = insert(:category, %{name: "B category"})
      category_a = insert(:category, %{name: "A category"})
      category_y = insert(:category, %{name: "Y category"})

      categories = ReadingList.list_categories()

      assert categories == [category_a, category_b, category_y, category_z]
    end
  end

  describe "mark_article_read!/1" do
    test "when the article is found and not read it sets the article as read" do
      article = insert(:article)

      assert {:ok, article} = ReadingList.mark_article_read!(article)
      assert article.read == true
    end
  end

  describe "recent_articles/0" do
    test "it returns the 5 recently added articles" do
      article_1 = insert(:article, inserted_at: Timex.shift(Timex.now(), days: -5))
      article_2 = insert(:article, inserted_at: Timex.shift(Timex.now(), days: -4))
      article_3 = insert(:article, inserted_at: Timex.shift(Timex.now(), days: -3))
      article_4 = insert(:article, inserted_at: Timex.shift(Timex.now(), days: -2))
      article_5 = insert(:article, inserted_at: Timex.shift(Timex.now(), days: -1))
      _article_6 = insert(:article, inserted_at: Timex.shift(Timex.now(), days: -7))

      _unpublished_article =
        insert(:article, inserted_at: Timex.shift(Timex.now(), days: -1), read: true)

      articles = ReadingList.recent_articles()

      assert articles == [article_5, article_4, article_3, article_2, article_1]
    end
  end
end
