defmodule Yaae.CacheUpdater do
  alias Yaae.Records

  def run do
    Records.destroy_all()

    RepoListFetcher.get_full_list() |> Enum.each(&Records.insert(&1))
  end
end
