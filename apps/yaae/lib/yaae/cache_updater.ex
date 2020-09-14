defmodule Yaae.CacheUpdater do
  @moduledoc """
  This module's job is to get list of repositories from RepoListFetcher app and insert every item into Redis cache.

  SchedEx calles run/0 every day at 00:00 to update repositories' info.
  """
  alias Yaae.Records

  def run do
    Records.destroy_all()

    RepoListFetcher.get_full_list() |> Enum.each(&Records.insert(&1))
  end
end
