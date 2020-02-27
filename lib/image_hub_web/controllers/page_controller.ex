defmodule ImageHubWeb.PageController do
  use ImageHubWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
