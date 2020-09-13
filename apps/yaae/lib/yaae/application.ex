defmodule Yaae.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Yaae.Repo,
      %{
        id: "cache_updater",
        start: {SchedEx, :run_every, [Yaae.CacheUpdater, :run, [], "0 0 * * *"]}
      },
      {Phoenix.PubSub, name: Yaae.PubSub}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Yaae.Supervisor)
  end
end
