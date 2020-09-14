defmodule RepoListFetcher.Fetchers.Github.AdditionalInfo do
  @moduledoc """
  Fetches additional info about repository: stars count and amount of days since last commit
  """
  import RepoListFetcher.Fetchers.Github.Client

  alias RepoListFetcher.RepoListItem

  def request(item) do
    item
    |> fetch_stars()
    |> fetch_days_since_last_commit()
  end

  @doc """
  Performs a request to Github API (`/repos/owner/repo`) to get information about repo's stars
  """
  def fetch_stars(%RepoListItem{owner: owner, repo: repo} = item) do
    case Tentacat.Repositories.repo_get(client_with_token(), owner, repo) do
      {200, %{"stargazers_count" => stars}, _} ->
        %RepoListItem{item | stars_count: stars}

      _ ->
        item
    end
  end

  @doc """
  Performs a request to Github API (`/repos/owner/repo/commits`) to get information about repo's commits.

  Commits are sorted by date and the first one is always the latest one. That means, we can just dig into the first
  item iof the response and calculate difference between today and date of the last commit.
  """
  def fetch_days_since_last_commit(%RepoListItem{owner: owner, repo: repo} = item) do
    case Tentacat.Commits.list(client_with_token(), owner, repo) do
      {200, items, _} when is_list(items) ->
        {:ok, date_time} =
          items
          |> hd()
          |> get_in(["commit", "author", "date"])
          |> Timex.parse("{ISO:Extended}")

        %RepoListItem{item | days_since_last_commit: Timex.diff(Timex.now(), date_time, :days)}

      _ ->
        item
    end
  end
end
