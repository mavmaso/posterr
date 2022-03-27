defmodule PosterrWeb.UserController do
  use PosterrWeb, :controller

  alias Posterr.Accounts
  alias Posterr.Accounts.Following
  alias Posterr.Accounts.User

  action_fallback PosterrWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def follow(conn, %{"follow_id" => follow_id, "user_id" => user_id}) do
    with {:ok, %User{} = user} <- Accounts.get_user(user_id),
        {:ok, %User{} = follow} <- Accounts.get_user(follow_id),
        {:ok, %Following{}, status} <- Accounts.toggle_follow(user, follow) do
      conn
      |> json(%{data: status})
    end
  end
end
