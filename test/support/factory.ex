defmodule Stevencwarren.Factory do
  use ExMachina.Ecto, repo: Stevencwarren.Repo

  def user_factory do
    %Stevencwarren.UserManager.User{
      email: sequence(:email, &"foo-#{&1}@foo.com"),
      password: "0U812"
    }
  end
end
