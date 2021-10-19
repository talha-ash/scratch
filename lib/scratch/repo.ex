defmodule Scratch.Repo do
  use Ecto.Repo,
    otp_app: :scratch,
    adapter: Ecto.Adapters.Postgres
end
