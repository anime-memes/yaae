defmodule Yaae.CacheUpdaterTest do
  use ExUnit.Case

  defmodule TestTimeScale do
    def now(_), do: Timex.now()

    def speedup, do: 86400
  end

  test "run/1 updates database every day at 00:00" do
    assert Yaae.Records.get_all() == []

    SchedEx.run_every(Yaae.CacheUpdater, :run, [], "0 0 * * *", time_scale: TestTimeScale)
    Process.sleep(1000)

    assert Yaae.Records.get_all() == RepoListFetcher.get_full_list()
  end
end
