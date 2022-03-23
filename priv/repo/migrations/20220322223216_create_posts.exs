defmodule Posterr.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :type, :string, null: false
      add :content, :text, null: false
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:posts, [:user_id])
  end
end
