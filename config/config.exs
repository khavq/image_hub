# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :image_hub, ImageHub.Accounts.Guardian,
  issuer: "image_hub",
  secret_key: "5UoIdzIpahurRThZZ0IDuAnv8GJ1X1YvG2UnJD4SWfDCwFRnK3IVAaz/XsefmpnY"

config :image_hub,
  ecto_repos: [ImageHub.Repo]

# Configures the endpoint
config :image_hub, ImageHubWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "3Geg4sfO44OmKD/IVwWofPuHJ9v8UlH2eEcn4DZL7I9phBx6Bjsz+8xgSbkOqXmy",
  render_errors: [view: ImageHubWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ImageHub.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "nK6qNkFc"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
