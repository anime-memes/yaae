defmodule Yaae.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Yaae.Repo,
      {Phoenix.PubSub, name: Yaae.PubSub}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Yaae.Supervisor)
  end
end
