defmodule Posterr.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :content, :string
    field :type, Ecto.Enum, values: [:original, :repost, :quote]

    belongs_to :user, Posterr.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:type, :content, :user_id])
    |> validate_required([:type, :content, :user_id])
    |> validate_length(:content, min: 1, max: 777)
  end
end
