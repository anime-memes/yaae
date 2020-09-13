defmodule Yaae.RepoTest do
  use ExUnit.Case

  alias RepoListFetcher.RepoListItem

  describe "reading values" do
    setup do
      records = RepoListFetcher.get_full_list()
      Enum.each(records, &Yaae.Records.insert(&1))

      on_exit(&Yaae.Records.destroy_all/0)

      {:ok, records: records}
    end

    test "keys/0 returns sorted list containing every key", %{records: records} do
      records_keys = Enum.map(records, fn record -> "#{record.platform}/#{record.owner}/#{record.repo}" end)

      assert Yaae.Repo.keys() == records_keys
    end

    test "get/1 returns correct struct", %{records: [record | _]} do
      assert Yaae.Repo.get("#{record.platform}/#{record.owner}/#{record.repo}") == record
    end
  end

  describe "setting values" do
    setup do
      on_exit(&Yaae.Records.destroy_all/0)
    end

    test "set/2 uses passed key to insert passed value" do
      records_before = Yaae.Records.get_all()
      new_record = %RepoListItem{owner: "owner", repo: "repo", platform: "github"}

      assert {:ok, "OK"} == Yaae.Repo.set("github/owner/repo", new_record)
      assert length(Yaae.Records.get_all()) == length(records_before) + 1
    end
  end

  describe "clearing database" do
    setup do
      records = RepoListFetcher.get_full_list()
      Enum.each(records, &Yaae.Records.insert(&1))
    end

    test "delete_all/0 deletes all data" do
      Yaae.Repo.delete_all()

      assert Yaae.Records.get_all() == []
    end
  end
end
