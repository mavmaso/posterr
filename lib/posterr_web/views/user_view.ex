defmodule PosterrWeb.UserView do
  use PosterrWeb, :view

  alias Posterr.Repo
  alias PosterrWeb.UserView
  alias Posterr.Accounts

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      joined: Date.to_string(user.inserted_at),
      count_posts: count_posts(user),
      followings: Accounts.count_followings_by_user(user.id),
      followers: Accounts.count_followers_by_user(user.id)
    }
  end

  defp count_posts(user) do
    user = Repo.preload(user, [:posts])
    length(user.posts)
  end
end
