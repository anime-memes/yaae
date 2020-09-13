defmodule RepoListFetcher.Client do
  # use GenServer

  # @list_owner "h4cc"
  # @list_repo "awesome-elixir"
  # @list_filename "README.md"

  # def start_link(_) do
  #   GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  # end

  # @impl GenServer
  # def init(_) do
  #   {:ok,
  #    Tentacat.Client.new(%{access_token: Application.get_env(:github_fetcher, :access_token)})}
  # end

  # def get_readme do
  #   GenServer.call(__MODULE__, :readme)
  # end

  # def get_repo_stars(owner, repo) do
  #   GenServer.call(__MODULE__, {:repo_stars, owner, repo})
  # end

  # def get_last_commit_date(owner, repo) do
  #   GenServer.call(__MODULE__, {:last_commit_date, owner, repo})
  # end

  # @impl GenServer
  # def handle_call(:readme, _, client) do
  #   case Tentacat.Repositories.Contents.content(client, @list_owner, @list_repo, @list_filename) do
  #     {200, %{"content" => content}, _} -> {:reply, {:ok, content}, client}
  #     _ -> {:reply, :error, client}
  #   end
  # end

  # @impl GenServer
  # def handle_call({:repo_stars, owner, repo}, _, client) do
  #   case Tentacat.Repositories.repo_get(client, owner, repo) do
  #     {200, %{"stargazers_count" => stars}, _} -> {:reply, {:ok, stars}, client}
  #     _ -> {:reply, :error, client}
  #   end
  # end

  # @impl GenServer
  # def handle_call({:last_commit_date, owner, repo}, _, client) do
  #   case Tentacat.Commits.list(client, owner, repo) do
  #     {200, items, _} when is_list(items) ->
  #       last_commit_date =
  #         items
  #         |> hd()
  #         |> get_in(["commit", "author", "date"])

  #       {:reply, {:ok, last_commit_date}, client}

  #     _ ->
  #       {:reply, :error, client}
  #   end
  # end
end
