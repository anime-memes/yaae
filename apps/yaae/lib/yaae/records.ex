defmodule Yaae.Records do
  alias Yaae.Repo
  alias RepoListFetcher.RepoListItem

  def get_all do
    Repo.keys()
    |> Enum.map(&Repo.get(&1))
    |> Enum.reject(&is_nil/1)
    |> Enum.sort_by(& &1.repo)
  end

  def get_by_stars(stars) do
    get_all() |> Enum.filter(fn record -> record.stars_count >= stars end)
  end

  def insert(%RepoListItem{platform: platform, owner: owner, repo: repo} = record) do
    Repo.set("#{platform}/#{owner}/#{repo}", record)
  end

  def destroy_all, do: Repo.delete_all()
end
