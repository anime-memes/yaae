defmodule YaaeWeb.PageView do
  use YaaeWeb, :view

  @doc """
  We need both categories list and grouped by category records. Everything is sorted alphabetically.
  """
  def records_categories(records),
    do: records |> Enum.map(& &1.category) |> Enum.uniq() |> Enum.sort()

  def grouped_records(records),
    do: Enum.group_by(records, & &1.category) |> Enum.sort_by(fn {key, _} -> key end)
end
