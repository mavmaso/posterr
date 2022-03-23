defmodule PosterrWeb.PostController do
  use PosterrWeb, :controller

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
end
