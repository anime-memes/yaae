defmodule Yaae.Records do
  @moduledoc """
  API for accessing Redis cache
  """
  alias Yaae.Repo
  alias RepoListFetcher.RepoListItem

  @doc """
  Fetches every record from Redis and sorts by repo name in alphabetical order
  """
  def get_all do
    Repo.keys()
    |> Enum.map(&Repo.get(&1))
    |> Enum.reject(&is_nil/1)
    |> Enum.sort_by(& &1.repo)
  end

  @doc """
  Calls get_all/0 and filters records by stars count
  """
  def get_by_stars(stars) do
    get_all() |> Enum.filter(fn record -> record.stars_count >= stars end)
  end

  @doc """
  Inserts new record into Redis. Platform-owner-repo is unique so we can use it as a key
  """
  def insert(%RepoListItem{platform: platform, owner: owner, repo: repo} = record) do
    Repo.set("#{platform}/#{owner}/#{repo}", record)
  end

  def destroy_all, do: Repo.delete_all()
end
