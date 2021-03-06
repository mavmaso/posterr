defmodule Posterr.Accounts.Following do
  use Ecto.Schema
  import Ecto.Changeset

  schema "following" do
    belongs_to :user, Posterr.Accounts.User
    belongs_to :follow, Posterr.Accounts.User, foreign_key: :follow_id

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:user_id, :follow_id])
    |> validate_required([:user_id, :follow_id])
    |> unique_constraint([:user_id, :follow_id], name: :followship)
    |> validate_yourself()
  end

  defp validate_yourself(changeset) do
    case changeset.changes.user_id != changeset.changes.follow_id do
      true ->
        changeset

      _ ->
        %{changeset | errors: changeset.errors ++ ["can't be yourself"], valid?: false}
    end
  end
end
