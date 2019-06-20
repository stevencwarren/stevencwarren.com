defmodule Stevencwarren.Repo do
  use Ecto.Repo,
    otp_app: :stevencwarren,
    adapter: Ecto.Adapters.Postgres
end
