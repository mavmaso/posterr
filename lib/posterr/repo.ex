defmodule Posterr.Repo do
  use Ecto.Repo,
    otp_app: :posterr,
    adapter: Ecto.Adapters.Postgres
end
