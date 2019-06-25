defmodule Stevencwarren.Factory do
  use ExMachina.Ecto, repo: Stevencwarren.Repo

  def user_factory do
    %Stevencwarren.UserManager.User{
      email: sequence(:email, &"email-#{&1}@example.com"),
      password: "0U812"
    }
  end
end
