defmodule Posterr.Blog do
  @moduledoc """
  The Blog context.
  """

  import Ecto.Query, warn: false
  alias Posterr.Repo

  alias Posterr.Blog.Post

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    Post
    |> preload([:user])
    |> Repo.all()
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id), do: Repo.get!(Post, id) |> Repo.preload([:user])

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{data: %Post{}}

  """
  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end

  @doc """
  Returns if it's possible or not to the user create one more post today
  """
  @spec post_per_day(user_id :: String.t() | integer()) :: :ok | {:error, :too_many_posts}
  def post_per_day(user_id) do
    cond do
      count_post_per_day(user_id) <= 4 -> :ok
      true -> {:error, :too_many_posts}
    end
  end

  defp count_post_per_day(user_id) do
    Post
    |> where([p], p.user_id == ^user_id)
    |> where([p], fragment("?::date", p.inserted_at) == ^Date.utc_today)
    |> Repo.all()
    |> length()
  end

  @doc """
  Returns a %Scrivener.Page{} with all post inside. Using default page_size.
  """
  @spec list_all(page :: integer()) :: Scrivener.Page.t()
  def list_all(page) do
    Post
    |> preload([:user])
    |> Repo.paginate(page: page)
  end

  @doc """
  Returns a %Scrivener.Page{} with all post for one user inside.
  """
  def user_posts(user_id, page) do
    Post
    |> where([p], p.user_id == ^user_id)
    |> order_by([p], desc: p.inserted_at)
    |> Repo.paginate(page: page, page_size: 5)
  end
end
