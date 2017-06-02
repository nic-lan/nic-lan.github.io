defmodule API.Authentication do
  import Plug.Conn

  def init(opts) do
    opts
  end

  def call(conn, opts) do
    conn
    |> send_resp(401, "unauthorized")
    |> halt
  end
end
