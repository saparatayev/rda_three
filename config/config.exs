# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :rda_three,
  ecto_repos: [RdaThree.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :rda_three, RdaThreeWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: RdaThreeWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: RdaThree.PubSub,
  live_view: [signing_salt: "r4hwOWWj"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :rda_three, RdaThreeWeb.Auth.Guardian,
  issuer: "rda_three",
  secret_key: "NUhFN03EkU2KVRhcbUbK1+8fHjd+/ztEoGiaXdUf+aHE7Iblw3PwKDnky6C8JmAH"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :guardian, Guardian.DB,
  repo: RdaThree.Repo,
  schema_name: "guardian_tokens",
  sweep_interval: 60

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
