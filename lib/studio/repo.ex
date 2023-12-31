defmodule Studio.Repo do
  use Ecto.Repo,
    otp_app: :studio,
    adapter: Ecto.Adapters.Postgres
end
