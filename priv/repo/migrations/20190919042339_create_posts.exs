defmodule Stevencwarren.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :body, :text
      add :published_on, :date
      add :tags, {:array, :string}

      add :category_id, references(:categories)

      timestamps()
    end

    create index(:posts, [:published_on, :category_id])
  end
end
