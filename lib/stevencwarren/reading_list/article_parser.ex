defmodule Stevencwarren.ReadingList.ArticleParser do
  import Floki

  def fetch_data(url) do
    {:ok, %HTTPoison.Response{status_code: 200, body: body}} = HTTPoison.get url

    require IEx; IEx.pry

    title = body |> Floki.text("title", deep: false)

    title
  end
end
