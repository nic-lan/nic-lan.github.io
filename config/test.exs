use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :nic_lan, NicLan.Endpoint,
  http: [port: 4001],
  server: true

# Print only warnings and errors during test
config :logger, level: :warn

# Hound
config :hound, driver: "phantomjs"

config :nic_lan,
  api_key: "super secret"
