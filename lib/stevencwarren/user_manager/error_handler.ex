defmodule Stevencwarren.UserManager.ErrorHandler do
  @moduledoc """
    Handles authentication errors and redirects unauthenticated users
    to `/login`
  """

  use StevencwarrenWeb, :controller
  import Plug.Conn

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, _params, _opts) do
    conn
    |> put_resp_content_type("text/plain")
    |> put_flash(:error, "You need to login before you access this page")
    |> redirect(to: Routes.session_path(conn, :login))
  end
end
