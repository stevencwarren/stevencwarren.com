defmodule Stevencwarren.HttpAdapter do
  @moduledoc false

  def get(url, headers \\ [], options \\ []) do
    HTTPoison.get(url, headers, options)
  end
end
