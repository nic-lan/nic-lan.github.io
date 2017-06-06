defmodule API.Posts.ConnectController do
  use NicLan.Web, :controller

  def create(conn, _params) do
    put_status(conn, :ok)
  end
end
