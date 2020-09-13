defmodule YaaeWeb.PageController do
  use YaaeWeb, :controller

  alias Yaae.Records

  def index(conn, %{"stars" => stars}) do
    render(conn, "index.html", records: Records.get_by_stars(String.to_integer(stars)))
  end

  def index(conn, _params) do
    render(conn, "index.html", records: Records.get_all())
  end
end
