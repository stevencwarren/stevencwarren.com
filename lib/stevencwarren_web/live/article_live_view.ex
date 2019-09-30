defmodule StevencwarrenWeb.ArticleLiveView do
  use Phoenix.LiveView

  def render(assigns) do
    StevencwarrenWeb.ArticleView.render("_articles.html", assigns)
  end

  def mount(%{categories: categories, changeset: changeset, recent_articles: recent_articles, user: user}, socket) do
    {:ok, assign(socket, %{categories: categories, changeset: changeset, recent_articles: recent_articles, user: user}) }
  end
end
