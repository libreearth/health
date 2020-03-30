# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :health,
  ecto_repos: [Health.Repo]

# Configures the endpoint
config :health, HealthWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "uQkqQwkQQbG9lj/w5lgJ/FRWUujEQZ1RsHEr5nAIO4JxAkWpf8dXeOiObV7I8zol",
  render_errors: [view: HealthWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Health.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "UPdoJiFT"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :health, :pow,
  user: Health.Users.User,
  repo: Health.Repo,
  web_module: HealthWeb

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
