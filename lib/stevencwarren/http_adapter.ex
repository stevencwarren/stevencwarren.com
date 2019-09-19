defmodule Stevencwarren.HttpAdapter do
  def get(url, headers \\ [], options \\ []) do
    HTTPoison.get(url, headers, options)
  end
end
