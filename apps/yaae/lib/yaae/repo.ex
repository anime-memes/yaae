defmodule Yaae.Repo do
  @moduledoc """
  Redis cache
  """

  @hostname Application.get_env(:yaae, :hostname)
  @db_name Application.get_env(:yaae, :db_name)

  alias RepoListFetcher.RepoListItem

  def start_link(_) do
    Redix.start_link(@hostname, name: @db_name)
  end

  def keys do
    case Redix.command(@db_name, ["KEYS", "*"]) do
      {:ok, keys} when is_list(keys) -> Enum.sort(keys)
      _ -> []
    end
  end

  def set(key, value) do
    {:ok, encoded} = Jason.encode(value)
    Redix.command(@db_name, ["SET", key, encoded])
  end

  def get(key) do
    case Redix.command(@db_name, ["GET", key]) do
      {:ok, value} when not is_nil(value) ->
        struct(RepoListItem, Jason.decode!(value, keys: :atoms))

      _ ->
        nil
    end
  end

  def delete_all do
    Redix.command(@db_name, ["FLUSHDB"])
  end

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      type: :worker,
      restart: :permanent,
      shutdown: 5000
    }
  end
end
