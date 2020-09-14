defmodule RepoListFetcher.GithubTest do
  use ExUnit.Case

  import Mock

  alias RepoListFetcher.Fetchers.Github
  alias RepoListFetcher.RepoListItem

  defp content do
    File.read!("./test/test_readme.md") |> Base.encode64()
  end

  test "get_actual_list/0 parses readme file and builds full repo items list" do
    with_mocks([
      {Tentacat.Repositories.Contents, [],
       [content: fn _, _, _, _ -> {200, %{"content" => content()}, %{}} end]},
      {Tentacat.Repositories, [],
       [repo_get: fn _, _, _ -> {200, %{"stargazers_count" => 10}, %{}} end]},
      {Tentacat.Commits, [],
       [
         list: fn _, _, _ ->
           {200, [%{"commit" => %{"author" => %{"date" => "2020-01-01T00:00:01Z"}}}], %{}}
         end
       ]}
    ]) do
      {:ok, date_time} = Timex.parse("2020-01-01T00:00:01Z", "{ISO:Extended}")
      days_diff = Timex.diff(Timex.now(), date_time, :days)

      expected = [
        %RepoListItem{
          category: "Category1",
          owner: "owner1",
          repo: "repo1",
          description: "Description 1.",
          platform: "github",
          stars_count: 10,
          days_since_last_commit: days_diff
        },
        %RepoListItem{
          category: "Category2",
          owner: "owner2",
          repo: "repo2",
          description: "Description 2.",
          platform: "github",
          stars_count: 10,
          days_since_last_commit: days_diff
        },
        %RepoListItem{
          category: "Category2",
          owner: "owner3",
          repo: "repo3",
          description: "Description 3.",
          platform: "github",
          stars_count: 10,
          days_since_last_commit: days_diff
        },
        %RepoListItem{
          category: "Category2",
          owner: "owner4",
          repo: "repo4",
          description: "Description 4.",
          platform: "github",
          stars_count: 10,
          days_since_last_commit: days_diff
        },
        %RepoListItem{
          category: "Category3",
          owner: "owner5",
          repo: "repo5",
          description: "Description 5.",
          platform: "github",
          stars_count: 10,
          days_since_last_commit: days_diff
        },
        %RepoListItem{
          category: "Category3",
          owner: "owner6",
          repo: "repo6",
          description: "Description 6.",
          platform: "github",
          stars_count: 10,
          days_since_last_commit: days_diff
        },
        %RepoListItem{
          category: "Category4",
          owner: "owner7",
          repo: "repo7",
          description: "Description 7.",
          platform: "github",
          stars_count: 10,
          days_since_last_commit: days_diff
        },
        %RepoListItem{
          category: "Category5",
          owner: "owner8",
          repo: "repo8",
          description: "Description 8.",
          platform: "github",
          stars_count: 10,
          days_since_last_commit: days_diff
        }
      ]

      assert Enum.sort_by(Github.get_actual_list(), & &1.repo) == expected
    end
  end
end
