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
  secret_key_base: System.get_env("SECRET_KEY"),
  render_errors: [view: TweetrackWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Tweetrack.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :extwitter, :oauth, [
   consumer_key: System.get_env("TWITTER_CONSUMER_KEY"),
   consumer_secret: System.get_env("TWITTER_CONSUMER_SECRET"),
   access_token: System.get_env("TWITTER_ACCESS_TOKEN"),
   access_token_secret: System.get_env("TWITTER_ACCESS_TOKEN_SECRET")
]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure your database
config :tweetrack, Tweetrack.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("DATABASE_USERNAME"),
  password: System.get_env("DATABASE_PASSWORD"),
  database: System.get_env("DATABASE_NAME"),
  hostname: System.get_env("DATABASE_HOST"),
  pool_size: 10

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
