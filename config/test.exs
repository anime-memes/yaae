use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :yaae,
  hostname: "redis://localhost:6379/3",
  db_name: :redix_test

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :yaae_web, YaaeWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :repo_list_fetcher,
  platforms: [RepoListFetcher.Fetchers.Test],
  github_endpoint: "http://localhost:4000/"
