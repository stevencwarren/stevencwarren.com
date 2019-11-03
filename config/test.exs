use Mix.Config

# Configure your database
database_url = case System.get_env("DATABASE_URL") do
   nil ->
    config :stevencwarren, Stevencwarren.Repo,
      username: "swarren",
      password: "",
      database: "stevencwarren_test",
      hostname: "localhost",
      show_sensitive_data_on_connection_error: true,
      pool: Ecto.Adapters.SQL.Sandbox
  _ ->
  config :stevencwarren, Stevencwarren.Repo,
    url: System.get_env("DATABASE_URL"),
    pool: Ecto.Adapters.SQL.Sandbox
end

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :stevencwarren, StevencwarrenWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
