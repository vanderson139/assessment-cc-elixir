import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :assessment_cc_elixir_sr_01, AssessmentCcElixirSr01.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "assessment_cc_elixir_sr_01_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :assessment_cc_elixir_sr_01, AssessmentCcElixirSr01Web.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "7OswrzJI+SIlbQ+Fj/zElI49Oor7IOBTmunLRzQcJl6Je64A8UBgTph8zdI8FDde",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
