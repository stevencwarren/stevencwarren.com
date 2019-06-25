defmodule Stevencwarren.UserManagerTest do
  use Stevencwarren.DataCase

  alias Stevencwarren.UserManager

  @tag :focus
  describe "users" do
    alias Stevencwarren.UserManager.User
    import Stevencwarren.Factory

    @tag :skip
    test "authenticate_user/2 when a user exists and has a correct password" do
      user = insert(:user)

      resp = UserManager.authenticate_user(user.email, user.password)
      assert(resp) == { :ok, user }
    end

    test "change_user/1 returns a user changeset" do
      user = %User{  }

      assert User.changeset(user, %{}) == UserManager.change_user(user)
    end
  end
end
