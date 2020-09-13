defmodule RepoListFetcher.Fetchers.Github do
  @behaviour RepoListFetcher.Fetchers.Fetcher

  alias RepoListFetcher.RepoListItem

  def get_actual_list do
    []
  end

  # def readme do
  #   case Client.get_readme() do
  #     {:ok, content} -> content |> String.replace("\n", "") |> Base.decode64()
  #     _ -> nil
  #   end
  # end

  # def stars_count(owner, repo) do
  #   case Client.get_repo_stars(owner, repo) do
  #     {:ok, stars} -> stars
  #     _ -> nil
  #   end
  # end

  # def days_since_last_commit(owner, repo) do
  #   case Client.get_last_commit_date(owner, repo) do
  #     {:ok, date_time_str} ->
  #       {:ok, date_time} = Timex.parse(date_time_str, "{ISO:Extended}")
  #       Timex.diff(Timex.now(), date_time, :days)

  #     _ ->
  #       nil
  #   end
  # end
end
