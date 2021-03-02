use Mix.Config

# Configure your database
config :stevencwarren, Stevencwarren.Repo,
  username: System.get_env["PG_USER"],
  password: System.get_env["PG_PASSWORD"],
  hostname: System.get_env["PG_HOST"],
  show_sensitive_data_on_connection_error: true,
  database: "#{System.get_env["PG_DATABASE"]}_test",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :stevencwarren, StevencwarrenWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
