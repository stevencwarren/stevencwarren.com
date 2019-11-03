# test/stevencwarren_web/controllers/admin/category_controller_test.exs

defmodule StevencwarrenWeb.Admin.CategoryControllerTest do
  use StevencwarrenWeb.ConnCase
  import Stevencwarren.Factory
  alias Stevencwarren.ReadingList.Category
  alias Stevencwarren.Repo
  alias Ecto.Query
  import Stevencwarren.UserManager.Guardian

  setup do
    user = insert(:user)

    {:ok, token, _} = encode_and_sign(user, %{}, token_type: :access)

    {:ok, token: token}
  end

  describe "index" do
    test "returns all of the categories", %{conn: conn, token: token} do
      insert(:category, %{name: "A Category"})
      insert(:category, %{name: "B Category"})
      insert(:category, %{name: "C Category"})
      insert(:category, %{name: "Z Category"})

      conn =
        conn
        |> put_req_header("authorization", "Bearer: " <> token)
        |> get(Routes.admin_category_path(conn, :index))

      assert html_response(conn, 200) =~ "A Category"
      assert html_response(conn, 200) =~ "B Category"
      assert html_response(conn, 200) =~ "C Category"
      assert html_response(conn, 200) =~ "Z Category"
    end
  end

  describe "new" do
    test "it renders the new category form", %{conn: conn, token: token} do
      conn =
        conn
        |> put_req_header("authorization", "Bearer: " <> token)
        |> get(Routes.admin_category_path(conn, :new))

      assert html_response(conn, 200) =~ "Create a new Category"
      assert html_response(conn, 200) =~ "Name"
      assert html_response(conn, 200) =~ "Submit"
    end
  end

  describe "create" do
    test "when there are valid parameters", %{conn: conn, token: token} do
      params = %{"category" => %{name: "Foo"}}

      conn =
        conn
        |> put_req_header("authorization", "Bearer: " <> token)
        |> post(Routes.admin_category_path(conn, :create), params)

      assert get_flash(conn, :info) =~ "Category created successfully"

      query = Query.last(Category)
      last_category =  query |> Repo.one()
      assert last_category.name == "Foo"
    end

    test "when there are invalid parameters", %{conn: conn, token: token} do
      params = %{"category" => %{foo: "bar"}}

      conn =
        conn
        |> put_req_header("authorization", "Bearer: " <> token)
        |> post(Routes.admin_category_path(conn, :create), params)

      assert html_response(conn, 200) =~ "Create a new Category"
    end
  end
end
