defmodule StevencwarrenWeb.PageControllerTest do
  use StevencwarrenWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")

    assert html_response(conn, 200) =~ "Hello, welcome to my small section of the internet."
  end
end
