defmodule United.Repo do
  use Ecto.Repo,
    otp_app: :united,
    adapter: Ecto.Adapters.Postgres
end
