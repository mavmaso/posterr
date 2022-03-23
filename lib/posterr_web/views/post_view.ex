defmodule PosterrWeb.PostView do
  use PosterrWeb, :view

  alias Posterr.Repo
  alias PosterrWeb.PostView
  alias PosterrWeb.UserView

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    post = Repo.preload(post, [:user])

    %{
      id: post.id,
      type: post.type,
      content: post.content,
      user: UserView.render("user.json", user: post.user)
    }
  end
end
