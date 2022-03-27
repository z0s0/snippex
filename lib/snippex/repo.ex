defmodule Snippex.Repo do
  use Ecto.Repo,
    otp_app: :snippex,
    adapter: Ecto.Adapters.Postgres
end
