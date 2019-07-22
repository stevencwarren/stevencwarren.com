defmodule Stevencwarren.ReadingList.ArticleParserTest do
  use ExUnit.Case
  alias Stevencwarren.ReadingList.ArticleParser

  describe "fetch_title" do
    test "it returns the title of the webpage" do
      url = "http://stevencwarren.com"

      assert ArticleParser.fetch_data(url) == "stevencwarren.com"
    end
  end
end
