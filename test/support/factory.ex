defmodule Stevencwarren.Factory do
  use ExMachina.Ecto, repo: Stevencwarren.Repo
  alias Stevencwarren.UserManager.User

  def user_factory do
    %Stevencwarren.UserManager.User{
      email: sequence(:email, &"foo-#{&1}@foo.com"),
      password: "0U812"
    }
  end

  def set_password(user, password) do
    user
    |> User.changeset(%{password: password})
    |> Ecto.Changeset.apply_changes()
  end
end
