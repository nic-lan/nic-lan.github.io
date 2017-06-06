defmodule API.Authentication do
  import Plug.Conn

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    conn
    |> get_req_header("authorization")
    |> require_authorization
    |> redirect(conn)
  end

  defp require_authorization([key]) do
    if(key == api_key(), do: :ok)
  end

  defp require_authorization(_), do: :error

  defp redirect(:ok, conn) do
    conn
  end

  defp redirect(_, conn) do
    conn
    |> send_resp(401, "unauthorized")
    |> halt
  end

  defp api_key, do: Application.get_env(:nic_lan, :api_key)
end
