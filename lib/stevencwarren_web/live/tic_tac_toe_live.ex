defmodule StevencwarrenWeb.TicTacToeLive do
  use Phoenix.LiveView

  alias StevencwarrenWeb.TicTacToeView
  alias TicTacToe.{GameSupervisor, Game}

  def render(assigns) do
    game = Game.via_tuple("foo")

    TicTacToeView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    GameSupervisor.start_game("foo")
    game = Game.via_tuple("foo")

    {:ok, assign(socket, game: Game.get_state(game))}
  end

  def handle_event("mark", %{"index" => index}, socket) do
    game = Game.via_tuple("foo")

    Game.add_mark(game, String.to_integer(index), "X")

    {:noreply, assign(socket, game: Game.get_state(game))}
  end
end
