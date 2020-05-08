# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :smile,
  ecto_repos: [Smile.Repo]

# Configures the endpoint
config :smile, SmileWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "jiXTR16PKfrd8dLntnTjdjlp00woeM1TAkjJ+mxCNwPWitHi+I2LGRw8zSu52tnG",
  render_errors: [view: SmileWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Smile.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "jvkLioiy"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
