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
  secret_key_base: "otBypA3ttcAK0zaUHDK9DEMnZdml0u7cb2nYckeNQv/LoCpT11O7CJdjLdpCSugN",
  render_errors: [view: StevencwarrenWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Stevencwarren.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "xXHQqUGehJwdK2y4VJoztlIUrVUVgh31tR8HVf89ysEYZXTIefaXxL+O3YDRRug8"]

config :stevencwarren, Stevencwarren.UserManager.Guardian,
  issuer: "stevencwarren",
  secret_key: "f8tnd5XsWSlBjMmMQTZD+b34E+zp0w2168tOe+Rhtmbrdo5oLso+RN+O1Ye/q3JF"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
