defmodule RepoListFetcher do
  @moduledoc """
  Module for hosting the RepoListItem struct and the main function of the app
  """
  defmodule RepoListItem do
    @moduledoc """
    Defines struct for items in repos list
    """

    @derive Jason.Encoder
    defstruct category: "",
              owner: "",
              repo: "",
              description: "",
              stars_count: nil,
              days_since_last_commit: nil,
              platform: ""

    @type t :: %__MODULE__{
            category: binary(),
            owner: binary(),
            repo: binary(),
            description: binary(),
            stars_count: integer(),
            days_since_last_commit: integer(),
            platform: binary()
          }
  end

  @doc """
  Calls get_actual_list/0 for every module in config list of platforms
  """
  def get_full_list do
    Application.get_env(:repo_list_fetcher, :platforms)
    |> Enum.map(&apply(&1, :get_actual_list, []))
    |> List.flatten()
  end
end
