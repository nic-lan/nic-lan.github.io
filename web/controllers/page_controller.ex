defmodule NicLan.PageController do
  use NicLan.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
