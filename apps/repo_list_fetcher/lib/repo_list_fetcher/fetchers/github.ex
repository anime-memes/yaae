defmodule RepoListFetcher.Fetchers.Github do
  @moduledoc """
  Github fetcher

  Fetching data from Github API performs using Tasks
  """
  @behaviour RepoListFetcher.Fetchers.Fetcher
  @timeout 60_000

  alias RepoListFetcher.Fetchers.Github.{AdditionalInfo, Readme}

  @doc """
  Parses README.md from github repository to build list of RepoListItems and
  creates tasks that get stars count and commit date info for every item
  """
  def get_actual_list do
    Readme.parse()
    |> get_additional_info()
    |> Enum.map(fn
      {:ok, result} -> result
      _ -> []
    end)
  end

  # Creates tasks stream
  # No tasks linked to caller, so one fail won't crash the system/
  # Instead tasks are supervised by Task.Supervisor
  defp get_additional_info(items) do
    Task.Supervisor.async_stream_nolink(
      RepoListFetcher.TaskSupervisor,
      items,
      AdditionalInfo,
      :request,
      [],
      max_concurrency: 50,
      timeout: @timeout,
      shutdown: :brutal_kill
    )
  end
end
