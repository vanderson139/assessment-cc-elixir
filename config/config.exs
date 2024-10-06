# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :assessment_cc_elixir_sr_01,
  ecto_repos: [AssessmentCcElixirSr01.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :assessment_cc_elixir_sr_01, AssessmentCcElixirSr01Web.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: AssessmentCcElixirSr01Web.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: AssessmentCcElixirSr01.PubSub,
  live_view: [signing_salt: "+OYhiBga"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
