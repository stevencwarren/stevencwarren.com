defmodule Stevencwarren.ReadingList.ArticleParserTest do
  use ExUnit.Case
  alias Stevencwarren.ReadingList.ArticleParser

  describe "fetch_title" do
    test "it returns the title of the webpage" do
      url = "https://stevencwarren.com"

      %{title: title, description: description} = ArticleParser.get_title_and_description(url)

      assert title == "Steven Warren - Developer, Dad, Overalls Advocate"

      assert description ==
               "The personal website of Steven Warren. I am an Ruby and Elixir engineer who enjoys programming and camping."
    end
  end
end
