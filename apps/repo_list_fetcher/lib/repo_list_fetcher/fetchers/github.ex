defmodule RepoListFetcher.Fetchers.Github do
  @moduledoc """
  Github fetcher

  Fetching data from Github API performs using Tasks
  """
  @behaviour RepoListFetcher.Fetchers.Fetcher

  alias RepoListFetcher.Fetchers.Github.{AdditionalInfo, Readme}

  @doc """
  Parses README.md from github repository to build list of RepoListItems and
  creates tasks that get stars count and commit date info for every item
  """
  def get_actual_list do
    Readme.parse()
    |> Enum.map(&get_additional_info/1)
    |> Task.yield_many(60_000)
    |> Enum.map(fn {task, res} -> res || Task.shutdown(task, :brutal_kill) end)
    |> Enum.map(fn
      {:ok, result} -> result
      _ -> []
    end)
  end

  # Creates task that is not linked to caller and instead is supervised by Task.Supervisor
  defp get_additional_info(item) do
    Task.Supervisor.async_nolink(
      RepoListFetcher.TaskSupervisor,
      AdditionalInfo,
      :request,
      [item],
      shutdown: :brutal_kill
    )
  end
end
