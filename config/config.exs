# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :tweetrack,
  ecto_repos: [Tweetrack.Repo]

# Configures the endpoint
config :tweetrack, TweetrackWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "VPBxDe5CPkNzKJa8Lc7PbnUUdXrN9GjpRJtbC5EkjZTafK8DLh6ptFTFL1Mk4oMw",
  render_errors: [view: TweetrackWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Tweetrack.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
