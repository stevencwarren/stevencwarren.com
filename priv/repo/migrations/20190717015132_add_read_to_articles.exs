defmodule Stevencwarren.Repo.Migrations.AddReadToArticles do
  use Ecto.Migration

  def change do
    alter table(:articles) do
      add :read, :boolean, default: false
    end

    create index(:articles, [:read])
  end
end
