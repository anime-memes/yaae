defmodule RepoListFetcher.Fetchers.Github do
  @behaviour RepoListFetcher.Fetchers.Fetcher

  alias RepoListFetcher.Fetchers.Github.{AdditionalInfo, Readme}

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
