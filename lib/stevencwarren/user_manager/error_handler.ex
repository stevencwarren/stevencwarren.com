defmodule Stevencwarren.UserManager.ErrorHandler do
  use StevencwarrenWeb, :controller
  import Plug.Conn

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {type, _reason}, _opts) do
    body = to_string(type)
    conn
    |> put_resp_content_type("text/plain")
    |> put_flash(:error, "You need to login before you access this page")
    |> redirect(to: Routes.session_path(conn, :login))
  end
end
