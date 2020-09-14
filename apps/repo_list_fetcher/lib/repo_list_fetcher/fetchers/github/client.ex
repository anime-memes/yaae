defmodule RepoListFetcher.Fetchers.Github.Client do
  @moduledoc """
  Github API client, access_token and endpoint have to be set in config
  """

  def client_with_token,
    do:
      Tentacat.Client.new(
        %{access_token: Application.get_env(:repo_list_fetcher, :github_access_token)},
        Application.get_env(:repo_list_fetcher, :github_endpoint)
      )
end
