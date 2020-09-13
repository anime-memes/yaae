defmodule YaaeWeb.PageViewTest do
  use YaaeWeb.ConnCase, async: true

  import Phoenix.View

  alias RepoListFetcher.RepoListItem

  setup do
    records = [
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
        category: "category2",
        owner: "owner2",
        repo: "repo2",
        description: "description2",
        stars_count: 20,
        days_since_last_commit: 2,
        platform: "github"
      },
      %RepoListItem{
        category: "category2",
        owner: "owner3",
        repo: "repo3",
        description: "description3",
        stars_count: 30,
        days_since_last_commit: 3,
        platform: "github"
      },
      %RepoListItem{
        category: "category3",
        owner: "owner4",
        repo: "repo4",
        description: "description4",
        stars_count: 40,
        days_since_last_commit: 4,
        platform: "github"
      },
      %RepoListItem{
        category: "category1",
        owner: "owner5",
        repo: "repo5",
        description: "description5",
        stars_count: 50,
        days_since_last_commit: 5,
        platform: "github"
      }
    ]

    {:ok, records: records}
  end

  test "renders index.html with every category and repo info from passed to template records", %{
    conn: conn,
    records: records
  } do
    content = render_to_string(YaaeWeb.PageView, "index.html", conn: conn, records: records)

    for record <- records do
      assert String.contains?(content, record.category)
      assert String.contains?(content, record.repo)
      assert String.contains?(content, record.description)
      assert String.contains?(content, "#{record.stars_count}⭐")
      assert String.contains?(content, "#{record.days_since_last_commit}🗓")
    end
  end

  test "record_categories/1 build the list of unique categories", %{records: records} do
    unique_categories = ~w(category1 category2 category3)
    assert unique_categories == YaaeWeb.PageView.records_categories(records)
  end
end
