# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Stevencwarren.Repo.insert!(%Stevencwarren.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
#

alias Stevencwarren.ReadingList
alias Stevencwarren.UserManager.User
alias Stevencwarren.Repo

Repo.delete_all(Stevencwarren.ReadingList.Category)
Repo.delete_all(User)

# Creating categories
ReadingList.create_category(%{ name: "Web Development"})
ReadingList.create_category(%{ name: "Economics"})
ReadingList.create_category(%{ name: "Politics"})
ReadingList.create_category(%{ name: "Fiction"})
ReadingList.create_category(%{ name: "Misc"})

# Create User
User.changeset(%User{}, %{ email: "steven@stevencwarren.com", password: "Passw0rd!" })
|> Repo.insert!
