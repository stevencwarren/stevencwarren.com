defmodule Stevencwarren.ReadingList.ArticleTest do
  use Stevencwarren.DataCase

  alias Stevencwarren.ReadingList.Article

  describe "changesets" do
    test "validates that the title is required" do
      changeset = Article.changeset(%Article{}, %{
        description: "foo",
        url: "http://foo.com"
      })

      refute changeset.valid?
    end

    test "validates that the url is required" do
      changeset = Article.changeset(%Article{}, %{
        title: "Foo title",
        description: "foo"
      })

      refute changeset.valid?
    end

    test "validates that the slug is required" do
      changeset = Article.changeset(%Article{}, %{
        title: "Foo title",
        description: "foo"
      })

      refute changeset.valid?
    end

    test "the article changeset generates the slug from the title" do
      changeset = Article.changeset(%Article{}, %{
        title: "Foo Title 123!!!",
        url: "https://foo.com"
      })

      {:ok, article} = Stevencwarren.Repo.insert(changeset)

      assert article.slug == "foo-title-123"
    end

    test "the article changeset creates a unique slugs" do
      Stevencwarren.Repo.insert(Article.changeset(%Article{}, %{
        title: "Foo Title",
        url: "https://foo.com"
      }))

      Stevencwarren.Repo.insert(Article.changeset(%Article{}, %{
        title: "Foo Title",
        url: "https://foo.com"
      }))

      changeset = Article.changeset(%Article{}, %{
        title: "Foo Title",
        url: "https://foo.com"
      })

      {:ok, dup} = Stevencwarren.Repo.insert(changeset)

      assert dup.slug == "foo-title-2"
    end
  end
end
