defmodule RepoListFetcher.Fetchers.Test do
  @behaviour RepoListFetcher.Fetchers.Fetcher

  alias RepoListFetcher.RepoListItem

  def get_actual_list do
    [
      %RepoListItem{
        category: "category1",
        owner: "owner1",
        repo: "repo1",
        description: "description1",
        stars_count: 10,
        days_since_last_commit: 1,
        platform: "github"
      },
      %RepoListItem{
        category: "category1",
        owner: "owner2",
        repo: "repo2",
        description: "description2",
        stars_count: 100,
        days_since_last_commit: 10,
        platform: "github"
      },
      %RepoListItem{
        category: "category2",
        owner: "owner3",
        repo: "repo3",
        description: "description3",
        stars_count: 1,
        days_since_last_commit: 100,
        platform: "github"
      },
      %RepoListItem{
        category: "category2",
        owner: "owner4",
        repo: "repo4",
        description: "description4",
        stars_count: 2,
        days_since_last_commit: 1000,
        platform: "github"
      },
      %RepoListItem{
        category: "category3",
        owner: "owner5",
        repo: "repo5",
        description: "description5",
        stars_count: 50,
        days_since_last_commit: 500,
        platform: "github"
      },
      %RepoListItem{
        category: "category3",
        owner: "owner6",
        repo: "repo6",
        description: "description6",
        stars_count: 120,
        days_since_last_commit: 50,
        platform: "github"
      }
    ]
  end
end
