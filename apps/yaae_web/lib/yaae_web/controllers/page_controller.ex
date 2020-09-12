defmodule YaaeWeb.PageController do
  use YaaeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
