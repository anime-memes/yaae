defmodule RepoListFetcher.MixProject do
  use Mix.Project

  def project do
    [
      app: :repo_list_fetcher,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {RepoListFetcher.Application, {}}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.0"},
      {:tentacat, "~> 2.1.0"},
      {:timex, "~> 3.5"},
      {:earmark, "~> 1.4.10"},
      {:meeseeks, "~> 0.15.1"},
      {:mock, "~> 0.3.0", only: :test}
    ]
  end
end
