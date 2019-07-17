defmodule Stevencwarren.Repo.Migrations.AddReadToArticles do
  use Ecto.Migration

  def change do
    alter table(:articles) do
      add :read, :boolean
    end

    create index(:articles, [:read])
  end
end
