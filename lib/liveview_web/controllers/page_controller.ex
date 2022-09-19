defmodule LiveviewWeb.PageController do
  use LiveviewWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
