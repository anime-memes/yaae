defmodule GithubFetcherTest do
  use ExUnit.Case
  doctest GithubFetcher

  test "greets the world" do
    assert GithubFetcher.hello() == :world
  end
end
