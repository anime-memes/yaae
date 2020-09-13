defmodule RepoListFetcher.Fetchers.Fetcher do
  alias RepoListFetcher.RepoListItem

  @callback get_actual_list :: list(RepoListItem.t())
end
