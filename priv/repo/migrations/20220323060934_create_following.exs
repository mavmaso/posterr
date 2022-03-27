defmodule Posterr.Repo.Migrations.CreateFollowing do
  use Ecto.Migration

  def change do
    create table(:following) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :follow_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:following, [:user_id, :follow_id], name: :followship)
  end
end
