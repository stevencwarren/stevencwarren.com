defmodule StevencwarrenWeb.TicTacToeController do
  use StevencwarrenWeb, :controller

  def index(conn, %{}) do
    conn
    |> live_render(StevencwarrenWeb.TicTacToeLive, session: %{})
  end
end
