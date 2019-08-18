defmodule StevencwarrenWeb.ArticleView do
  use StevencwarrenWeb, :view

  def link_text(article) do
    if article.title, do: article.title, else: article.url
  end
end
