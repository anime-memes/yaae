defmodule YaaeWeb.PageControllerTest do
  use YaaeWeb.ConnCase

  alias RepoListFetcher.RepoListItem
  alias Yaae.Records

  describe "GET /" do
    setup %{conn: conn} do
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
          stars_count: 100,
          days_since_last_commit: 2,
          platform: "github"
        },
        %RepoListItem{
          category: "category2",
          owner: "owner3",
          repo: "repo3",
          description: "description3",
          stars_count: 1000,
          days_since_last_commit: 3,
          platform: "github"
        }
      ]

      Enum.each(records, &Records.create(&1))
      on_exit(&Records.destroy_all/0)

      {:ok, conn: conn, records: records}
    end

    test "returns 200", %{conn: conn} do
      conn = get(conn, "/")
      assert html_response(conn, 200) =~ ~r/This is yet another Awesome Elixir list/
    end

    test "renders every category and repo without stars param", %{conn: conn, records: records} do
      conn = get(conn, "/")

      for record <- records do
        assert String.contains?(conn.resp_body, record.category)
        assert String.contains?(conn.resp_body, record.repo)
      end
    end

    test "renders only filtered categories and repos with stars param", %{
      conn: conn,
      records: records
    } do
      conn = get(conn, "/", %{"stars" => 50})

      for %{stars_count: stars_count} = record <- records do
        if stars_count >= 50 do
          assert String.contains?(conn.resp_body, record.category)
          assert String.contains?(conn.resp_body, record.repo)

        else
          refute String.contains?(conn.resp_body, record.category)
          refute String.contains?(conn.resp_body, record.repo)
        end
      end
    end
  end
end
