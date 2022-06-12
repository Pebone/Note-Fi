defmodule Av3.Repo do
  use Ecto.Repo,
    otp_app: :av3,
    adapter: Ecto.Adapters.Postgres
end
