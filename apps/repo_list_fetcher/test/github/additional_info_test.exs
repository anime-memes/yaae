defmodule RepoListFetcher.Github.AdditionalInfoTest do
  use ExUnit.Case

  import Mock

  alias RepoListFetcher.Fetchers.Github.AdditionalInfo
  alias RepoListFetcher.RepoListItem

  describe "fetch_stars/1" do
    test "with good response adds stars count to the list item" do
      item = %RepoListItem{owner: "owner", repo: "repo"}

      with_mock Tentacat.Repositories,
        repo_get: fn _, _, _ -> {200, %{"stargazers_count" => 10}, %{}} end do
        new_item = AdditionalInfo.fetch_stars(item)
        assert new_item.stars_count == 10
      end
    end

    test "with bad response doesn't change the item" do
      item = %RepoListItem{owner: "owner", repo: "repo"}

      with_mock Tentacat.Repositories, repo_get: fn _, _, _ -> {500, %{}, %{}} end do
        new_item = AdditionalInfo.fetch_stars(item)
        assert is_nil(new_item.stars_count)
      end
    end
  end

  describe "days_since_last_commit/1" do
    test "fetch_days_since_last_commit/1 adds the amount of days since last commit to the list item" do
      item = %RepoListItem{owner: "owner", repo: "repo"}

      with_mock Tentacat.Commits,
        list: fn _, _, _ ->
          {200, [%{"commit" => %{"author" => %{"date" => "2020-01-01T00:00:01Z"}}}], %{}}
        end do
        new_item = AdditionalInfo.fetch_days_since_last_commit(item)
        assert %RepoListItem{days_since_last_commit: days_since_last_commit} = new_item
        refute is_nil(days_since_last_commit)
      end
    end

    test "with bad response doesn't change the item" do
      item = %RepoListItem{owner: "owner", repo: "repo"}

      with_mock Tentacat.Commits, list: fn _, _, _ -> {500, [], %{}} end do
        new_item = AdditionalInfo.fetch_days_since_last_commit(item)
        assert is_nil(new_item.days_since_last_commit)
      end
    end
  end
end
