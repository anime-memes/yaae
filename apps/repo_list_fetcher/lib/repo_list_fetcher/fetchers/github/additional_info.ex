defmodule RepoListFetcher.Fetchers.Github.AdditionalInfo do
  import RepoListFetcher.Fetchers.Github.Client

  alias RepoListFetcher.RepoListItem

  def request(item) do
    item
    |> fetch_stars()
    |> fetch_days_since_last_commit()
  end

  def fetch_stars(%RepoListItem{owner: owner, repo: repo} = item) do
    case Tentacat.Repositories.repo_get(client_with_token(), owner, repo) do
      {200, %{"stargazers_count" => stars}, _} ->
        %RepoListItem{item | stars_count: stars}

      _ ->
        item
    end
  end

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
