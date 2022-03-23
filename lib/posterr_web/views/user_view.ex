defmodule PosterrWeb.UserView do
  use PosterrWeb, :view

  alias Posterr.Repo
  alias PosterrWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    user = Repo.preload(user, [:posts])

    %{
      id: user.id,
      username: user.username,
      joined: Date.to_string(user.inserted_at),
      count_posts: user.posts |> length()
    }
  end
end
