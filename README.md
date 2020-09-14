# YAAE (Yet Another Awesome Elixir)

  Another implementation of [awesome-elixir](https://github.com/h4cc/awesome-elixir) list using Elixir, Phoenix and Redis.

  ## Requirements
  * Elixir and Phoenix

  * [Redis](https://redis.io/) (default host is used, can be changed in config)

    `config :yaae, hostname: "redis_host_name", db_name: :db_name`

  * Installed [Rust compiler](https://www.rust-lang.org/tools/install) (`meeseeks` needs it for one of its dependencies)

  * [Create personal Github API token](https://github.blog/2013-05-16-personal-api-tokens/) and place it in your config

    `config :repo_list_fetcher, github_access_token: "123213213"`

  ## Running
  * Clone the repo
  * `cd yaae`
  * `mix deps.get`
  * `mix deps.compile` (takes a while because of `meeseeks`, like 10 minutes)
  * `mix run ./apps/yaae/priv/repo/seeds.exs` (performs initial population of the database, not required but otherwise you'd have to sit until 00:00 without data on screen)
  * `iex -S mix phx.server`
  * Open `localhost:4000` in browser

  ## Testing
  * `mix test` - only tests
  * `mix coveralls` - test coverage info
  * `mix dialyzer` - type specs
  * `mix credo` - code style
