defmodule Stevencwarren.ReadingList.ArticleParserTest do
  use ExUnit.Case
  alias Stevencwarren.ReadingList.ArticleParser

  describe "fetch_title" do
    test "it returns the title of the webpage" do
      url = "http://stevencwarren.com"

      #%{title: title, description: description } = ArticleParser.get_title_and_description(url)
      %{title: title, description: description } = ArticleParser.get_title_and_description(url)

      assert title == "stevencwarren.com"
      assert description == "The personal homepage of Steven Warren"
    end
  end
end
