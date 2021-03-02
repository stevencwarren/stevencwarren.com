# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :stevencwarren,
  ecto_repos: [Stevencwarren.Repo]

# Configures the endpoint
config :stevencwarren, StevencwarrenWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  render_errors: [view: StevencwarrenWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: Stevencwarren.PubSub,
  live_view: [signing_salt: System.get_env("LIVE_VIEW_SALT")]

config :stevencwarren, Stevencwarren.UserManager.Guardian,
  issuer: "stevencwarren",
  secret_key: System.get_env("GUARDIAN_SECRET_KEY")

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
