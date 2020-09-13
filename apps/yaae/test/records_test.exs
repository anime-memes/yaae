defmodule Yaae.RecordsTest do
  use ExUnit.Case
  alias RepoListFetcher.RepoListItem

  describe "reading records" do
    setup do
      records = RepoListFetcher.get_full_list()
      Enum.each(records, &Yaae.Records.insert(&1))

      on_exit(&Yaae.Records.destroy_all/0)

      {:ok, records: records}
    end

    test "get_all/0 fetches all the records and sorts them in alphabetical order using repo names", %{records: records} do
      assert Yaae.Records.get_all() == records
    end

    test "get_by_stars/1 fetches only those records that have required stars_count", %{records: records} do
      filtered_records = Yaae.Records.get_by_stars(50)

      refute records == filtered_records
      assert Enum.all?(filtered_records, fn record -> record.stars_count >= 50 end)
    end
  end

  describe "inserting records" do
    setup do
      on_exit(&Yaae.Records.destroy_all/0)
    end

    test "create/1 inserts new record into database using correct key" do
      old_values = Yaae.Records.get_all()

      record = %RepoListItem{owner: "owner", repo: "repo", platform: "github" }
      Yaae.Records.insert(record)

      assert length(Yaae.Records.get_all()) == length(old_values) + 1
      assert Enum.member?(Yaae.Repo.keys(), "github/owner/repo")
      assert Yaae.Repo.get("github/owner/repo") == record
    end
  end

  describe "deleting records" do
    setup do
      records = RepoListFetcher.get_full_list()
      Enum.each(records, &Yaae.Records.insert(&1))
    end

    test "destroy_all/0 deletes all keys from database" do
      Yaae.Records.destroy_all()
      assert Yaae.Repo.keys() == []
      assert Yaae.Records.get_all() == []
    end
  end
end
