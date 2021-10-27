defmodule SVWeb.PageController do
  use SVWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
