defmodule StevencwarrenWeb.LayoutView do
  use StevencwarrenWeb, :view
  alias Stevencwarren.UserManager.Guardian

  def logged_in?(conn)  do
    Guardian.Plug.authenticated?(conn)
  end
end
