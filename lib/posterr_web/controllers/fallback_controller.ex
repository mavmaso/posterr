defmodule PosterrWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use PosterrWeb, :controller

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(PosterrWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(PosterrWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, :too_many_posts}) do
    conn
    |> put_status(:bad_request)
    |> put_view(PosterrWeb.ErrorView)
    |> json(%{errors: "too many posts"})
  end

  def call(conn, {:error, :following_themselves}) do
    conn
    |> put_status(:bad_request)
    |> put_view(PosterrWeb.ErrorView)
    |> json(%{errors: "user can't following themselves"})
  end
end
