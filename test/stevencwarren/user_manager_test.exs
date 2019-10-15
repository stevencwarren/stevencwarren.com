defmodule Stevencwarren.UserManagerTest do
  use Stevencwarren.DataCase
  alias Stevencwarren.UserManager

  describe "users" do
    alias Stevencwarren.UserManager.User
    import Stevencwarren.Factory

    test "authenticate_user/2 when a user exists and has a correct password" do
      user = build(:user) |> set_password("secret") |> insert

      resp = UserManager.authenticate_user(user.email, "secret")

      assert resp == {:ok, user}
    end

    test "change_user/1 returns a user changeset" do
      user = %User{}

      assert User.changeset(user, %{}) == UserManager.change_user(user)
    end
  end
end
