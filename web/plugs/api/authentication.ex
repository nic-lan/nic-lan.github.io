defmodule API.Authentication do
  import Plug.Conn

  @auth_header_key "x-hub-signature"

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    IO.inspect conn
    # IO.inspect "body " <> conn.body_params["body"]
    IO.inspect "api key " <> api_key
    request_auth_key = get_key_to_digest(conn)
    IO.inspect "request_auth_key " <> request_auth_key
    expected_auth_key = compute_hmac(conn.body_params["body"])
    IO.inspect "expected_auth_key " <> expected_auth_key

    secure_compare(request_auth_key, expected_auth_key)
    |> redirect(conn)
  end

  defp get_key_to_digest(conn) do
    get_req_header(conn, @auth_header_key) |> List.first
  end

  defp compute_hmac(body) do
    "sha1=" <> (:crypto.hmac(:sha256, api_key(), body) |> Base.encode16)
  end

  defp secure_compare(request_key, expected_auth_key) do
    if(request_key == expected_auth_key, do: :ok)
  end

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
