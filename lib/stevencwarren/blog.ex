defmodule Stevencwarren.Blog do
  alias Stevencwarren.Repo

  @moduledoc """

  Blog Context that is responsible for showing blog posts
  """

  def list_posts do
    Repo.all(Stevencwarren.Blog.Post)
  end

  def create_post(attrs) do

  end
end
