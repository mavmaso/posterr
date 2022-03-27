defmodule PosterrWeb.PostController do
  use PosterrWeb, :controller

  alias Posterr.Accounts
  alias Posterr.Accounts.User
  alias Posterr.Blog

  action_fallback PosterrWeb.FallbackController

  def create(conn, %{"post" => params}) do
    with :ok <- Blog.post_per_day(params["user_id"]),
         {:ok, post} <- Blog.create_post(params) do
      conn
      |> put_status(:created)
      |> render("show.json", post: post)
    end
  end

  def index(conn, %{"page" => page, "user_id" => id}) do
    with {:ok, %User{}} <- Accounts.get_user(id),
         pages <- Blog.list_followings_posts(id, page) do
      conn
      |> render("index.json", posts: pages)
    end
  end

  def index(conn, %{"page" => page}) do
    with pages <- Blog.list_all(page) do
      conn
      |> render("index.json", posts: pages)
    end
  end

  def user_post(conn, %{"page" => page, "user_id" => user_id}) do
    with page <- Blog.user_posts(user_id, page) do
      conn
      |> render("index.json", posts: page)
    end
  end
end
