defmodule Stevencwarren.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title, :string
      add :description, :text
      add :url, :string
      add :slug, :string
      add :category_id, references(:categories)

      timestamps()
    end
  end
end
