defmodule RepoListFetcher.Github.ReadmeTest do
  use ExUnit.Case

  alias RepoListFetcher.RepoListItem
  alias RepoListFetcher.Fetchers.Github.Readme

  test "get_repos/1 correctly parses html string and builds list of RepoListItem" do
    readme = File.read!("./test/test_readme.md") |> Earmark.as_html!()

    expected = [
      %RepoListItem{
        category: "Category1",
        owner: "owner1",
        repo: "repo1",
        description: "Description 1.",
        platform: "github"
      },
      %RepoListItem{
        category: "Category2",
        owner: "owner2",
        repo: "repo2",
        description: "Description 2.",
        platform: "github"
      },
      %RepoListItem{
        category: "Category2",
        owner: "owner3",
        repo: "repo3",
        description: "Description 3.",
        platform: "github"
      },
      %RepoListItem{
        category: "Category2",
        owner: "owner4",
        repo: "repo4",
        description: "Description 4.",
        platform: "github"
      },
      %RepoListItem{
        category: "Category3",
        owner: "owner5",
        repo: "repo5",
        description: "Description 5.",
        platform: "github"
      },
      %RepoListItem{
        category: "Category3",
        owner: "owner6",
        repo: "repo6",
        description: "Description 6.",
        platform: "github"
      },
      %RepoListItem{
        category: "Category4",
        owner: "owner7",
        repo: "repo7",
        description: "Description 7.",
        platform: "github"
      },
      %RepoListItem{
        category: "Category5",
        owner: "owner8",
        repo: "repo8",
        description: "Description 8.",
        platform: "github"
      }
    ]

    assert Enum.sort_by(Readme.get_repos(readme), & &1.repo) == expected
  end
end
