defmodule StevencwarrenWeb.TicTacToeLive do
  use Phoenix.LiveView

  alias StevencwarrenWeb.TicTacToeView

  def render(assigns) do
    TicTacToeView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, socket}
  end
end
