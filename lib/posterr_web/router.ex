defmodule PosterrWeb.Router do
  use PosterrWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PosterrWeb do
    pipe_through :api

    resources "/users", UserController, only: [:create, :show, :index]
    resources "/posts", PostController, only: [:create, :index]
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: PosterrWeb.Telemetry
    end
  end

  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
