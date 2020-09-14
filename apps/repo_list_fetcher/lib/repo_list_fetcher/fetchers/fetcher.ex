defmodule RepoListFetcher.Fetchers.Fetcher do
  @moduledoc """
  Behaviour for fetchers

  Fetcher has to define get_actual_list/0 function that should return list where every element is RepoListItem
  """
  alias RepoListFetcher.RepoListItem

  @callback get_actual_list :: list(RepoListItem.t())
end
