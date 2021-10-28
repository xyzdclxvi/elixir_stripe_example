import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :sv, SVWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "GiiBei4fquebgSq1zzR1eyFgnPX3SDgtbHV1b1YMkOqMaQMDuLcqfLovCvwBMr+k",
  server: false

# In test we don't send emails.
config :sv, SV.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
