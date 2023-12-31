# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :x_budget_backend,
  ecto_repos: [XBudgetBackend.Repo]

# Configures the endpoint
config :x_budget_backend, XBudgetBackendWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: XBudgetBackendWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: XBudgetBackend.PubSub,
  live_view: [signing_salt: "ER/Pa3rj"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Guardian setup
config :x_budget_backend, XBudgetBackendWeb.Auth.Guardian,
  issuer: "x_budget_backend",
  secret_key: "N1p5HC8ReCCfQ9fZqzKXflfNuhDiCI9HVGBXY3DEt/hCopzzUh/9giZwbOALQOe8"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :guardian, Guardian.DB,
  repo: XBudgetBackend.Repo,
  schema_name: "guardian_tokens",
  # every 60 minutes sweeper removes expired tokens from DB
  sweep_interval: 60

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
