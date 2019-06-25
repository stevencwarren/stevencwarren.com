defmodule Stevencwarren.ReadingListTest do
  use Stevencwarren.DataCase

  alias Stevencwarren.ReadingList

  describe "articles" do
    alias Stevencwarren.ReadingList.Article

    @valid_attrs %{description: "some description", slug: "some slug", title: "some title", url: "some url"}
    @update_attrs %{description: "some updated description", slug: "some updated slug", title: "some updated title", url: "some updated url"}
    @invalid_attrs %{description: nil, slug: nil, title: nil, url: nil}

    def article_fixture(attrs \\ %{}) do
      {:ok, article} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ReadingList.create_article()

      article
    end

    test "list_articles/0 returns all articles" do
      article = article_fixture()
      assert ReadingList.list_articles() == [article]
    end

    test "get_article!/1 returns the article with given id" do
      article = article_fixture()
      assert ReadingList.get_article!(article.id) == article
    end

    test "create_article/1 with valid data creates a article" do
      assert {:ok, %Article{} = article} = ReadingList.create_article(@valid_attrs)
      assert article.description == "some description"
      assert article.slug == "some slug"
      assert article.title == "some title"
      assert article.url == "some url"
    end

    test "create_article/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ReadingList.create_article(@invalid_attrs)
    end

    test "update_article/2 with valid data updates the article" do
      article = article_fixture()
      assert {:ok, %Article{} = article} = ReadingList.update_article(article, @update_attrs)
      assert article.description == "some updated description"
      assert article.slug == "some updated slug"
      assert article.title == "some updated title"
      assert article.url == "some updated url"
    end

    test "update_article/2 with invalid data returns error changeset" do
      article = article_fixture()
      assert {:error, %Ecto.Changeset{}} = ReadingList.update_article(article, @invalid_attrs)
      assert article == ReadingList.get_article!(article.id)
    end

    test "delete_article/1 deletes the article" do
      article = article_fixture()
      assert {:ok, %Article{}} = ReadingList.delete_article(article)
      assert_raise Ecto.NoResultsError, fn -> ReadingList.get_article!(article.id) end
    end

    test "change_article/1 returns a article changeset" do
      article = article_fixture()
      assert %Ecto.Changeset{} = ReadingList.change_article(article)
    end
  end
end
