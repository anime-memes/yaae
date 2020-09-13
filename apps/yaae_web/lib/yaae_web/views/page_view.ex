defmodule YaaeWeb.PageView do
  use YaaeWeb, :view

  def records_categories(records), do: records |> Enum.map(& &1.category) |> Enum.uniq()

  def grouped_records(records), do: Enum.group_by(records, & &1.category)
end
