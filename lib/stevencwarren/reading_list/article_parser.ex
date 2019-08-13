defmodule Stevencwarren.ReadingList.ArticleParser do
  import Floki

  def get_title_and_description(url) do
    url
    |> fetch_data
    |> parse_response
  end

  defp fetch_data(url) do
    {:ok, %HTTPoison.Response{status_code: 200, body: body}} = HTTPoison.get url, [], [:follow_redirect]

    body
  end

  defp parse_response(body) do
    require IEx; IEx.pry
    %{
      title: body |> find("title") |> text,
      description: body
      |> find("meta[name='description']")
      |> attribute("content")
      |> text
    }
  end
end
