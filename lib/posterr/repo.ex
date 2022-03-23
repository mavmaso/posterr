defmodule Posterr.Repo do
  use Ecto.Repo,
    otp_app: :posterr,
    adapter: Ecto.Adapters.Postgres

  use Scrivener
end
