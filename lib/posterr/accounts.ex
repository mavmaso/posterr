defmodule Posterr.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Posterr.Repo

  alias Posterr.Accounts.User
  alias Posterr.Accounts.Following

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  WIP
  """
  def get_user(id) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  @doc """
  WIP
  """
  def toggle_follow(user, follow) do
    case check_follow(user.id, follow.id) do
      nil ->
        add_follow(%{user_id: user.id, follow_id: follow.id}) |> Tuple.append(:created)

      %Following{} = follow ->
        delete_follow(follow) |> Tuple.append(:ok)

      :error ->
        {:error, :following_themselves}
    end
  end

  defp check_follow(user_id, follow_id) when user_id == follow_id, do: :error

  defp check_follow(user_id, follow_id) do
    Following
    |> where([f], f.user_id == ^user_id)
    |> where([f], f.follow_id == ^follow_id)
    |> Repo.one()
  end

  @doc """
  WIP
  """
  def add_follow(attrs) do
    %Following{}
    |> Following.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  WIP
  """
  def delete_follow(%Following{} = follow), do: Repo.delete(follow)

  @doc """
  WIP
  """
  def count_followings_by_user(user_id) do
    Following
    |> where([f], f.user_id == ^user_id)
    |> Repo.aggregate(:count, :id)
  end

  @doc """
  WIP
  """
  def count_followers_by_user(user_id) do
    Following
    |> where([f], f.follow_id == ^user_id)
    |> Repo.aggregate(:count, :id)
  end

  @doc """
  WIP
  """
  def list_followings_ids_by_user(user_id) do
    Following
    |> where([f], f.user_id == ^user_id)
    |> select([f], f.follow_id)
    |> Repo.all()
  end
end
