defmodule RepoListFetcher.Fetchers.Github.Readme do
  @moduledoc """
  Fetches and parses README.md from awesome-elixir repository
  """

  import Meeseeks.CSS
  import RepoListFetcher.Fetchers.Github.Client

  alias RepoListFetcher.RepoListItem

  @list_owner "h4cc"
  @list_repo "awesome-elixir"
  @list_filename "README.md"

  def parse do
    get_readme() |> get_repos()
  end

  @doc """
  Performs a request to Github API (`/repos/owner/repo/contents`) to get README.md contents.
  Response is encoded with Base64, so we decode it and convert to html for easier parsing
  """
  def get_readme do
    case Tentacat.Repositories.Contents.content(
           client_with_token(),
           @list_owner,
           @list_repo,
           @list_filename
         ) do
      {200, %{"content" => content}, _} ->
        content
        |> String.replace("\n", "")
        |> Base.decode64!()
        |> Earmark.as_html!()

      _ ->
        nil
    end
  end

  @doc """
  Uses Meeseeks to look for categories and repositories by CSS selectors.

  First item of the first <ul> contains another <ul> with categories, so we get every item of that second <ul> and fetch their text

  Repos under categories have this structure:
    ```
    <h2>Category name</h2>
    <p>Category description</p>
    <ul>List of repositories</ul>
    ```
  So we get every <ul> (its index in overall list matches the category index), drop the last 10 (these are links after repositories)
  and build list of RepoListItem for every category
  """
  def get_repos(nil), do: []

  def get_repos(html_string) do
    categories =
      html_string
      |> Meeseeks.one(css("ul li ul"))
      |> Meeseeks.all(css("li"))
      |> Enum.map(&Meeseeks.text/1)

    repos =
      html_string
      |> Meeseeks.all(css("h2 + p + ul"))
      |> Enum.drop(-10)
      |> Enum.map(&Meeseeks.all(&1, css("li")))

    build_repos_list(categories, repos, []) |> Enum.reject(&is_nil/1)
  end

  # Right now we can set only owner name, repo name, github link and description.
  # Github link is located in `href` attribute of <a> (there may be non github link - such repositories are ignored).
  # Owner name and repo name located in github link.
  # Description is in the text.
  defp build_repos_list([], [], result_list), do: List.flatten(result_list)

  defp build_repos_list([category | category_tail], [repos | repos_tail], result) do
    repo_list_items =
      for repo <- repos do
        url =
          repo
          |> Meeseeks.one(css("a"))
          |> Meeseeks.attr("href")

        if url =~ "github.com" do
          [_, _, owner, repo_name | _] = String.split(url, "/", trim: true)

          description = Meeseeks.text(repo) |> String.split(" - ", trim: true) |> List.last()

          %RepoListItem{
            category: category,
            description: description,
            platform: "github",
            owner: String.downcase(owner),
            repo: String.downcase(repo_name)
          }
        end
      end

    build_repos_list(category_tail, repos_tail, [repo_list_items | result])
  end
end
