defmodule Stevencwarren.UserManager do
  alias Comeonin.Bcrypt
  import Ecto.Query, warn: false
  alias Stevencwarren.Repo
  alias Stevencwarren.UserManager.User

  def authenticate_user(email, plain_text_password) do
    query = from u in User, where: u.email == ^email

    case Repo.one(query) do
      nil ->
        Bcrypt.dummy_checkpw()
        { :error, :invalid_credentials }
      user ->
        if Bcrypt.checkpw(plain_text_password, user.password) do
          { :ok, user }
        else
        { :error, :invalid_credentials }
        end
    end
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def get_user!(id), do: Repo.get!(User, id)
end
