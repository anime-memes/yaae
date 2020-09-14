defmodule RepoListFetcher.Fetchers.Github.Client do
  def client_with_token,
    do:
      Tentacat.Client.new(
        %{access_token: Application.get_env(:repo_list_fetcher, :github_access_token)},
        Application.get_env(:repo_list_fetcher, :github_endpoint)
      )
end
