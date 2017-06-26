defmodule API.AuthenticationPlug do
  import Plug.Conn
  import Comeonin

  require Logger

  @auth_header_key "x-hub-signature"

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    # request_auth_key = get_key_to_digest(conn)
    # Logger.info IO.inspect "request_auth_key " <> request_auth_key
    # expected_auth_key = compute_hmac(conn.body_params)
    # Logger.info IO.inspect "expected_auth_key " <> expected_auth_key
    with {:ok, request_auth_key} <- get_key_to_digest(conn)
    do
      redirect(:ok, conn)
    else
      err -> redirect(:error, conn)
    end
  end

  defp get_key_to_digest(conn) do
    key_to_digest = get_req_header(conn, @auth_header_key) |> List.first

    case key_to_digest do
      nil -> {:error, Comeonin.Bcrypt.dummy_checkpw()}
      _   -> {:ok, key_to_digest}
    end
  end

  defp compute_hmac(body) do
    {:ok, encoded_body} = Poison.encode(body)
    "sha1=" <> (:crypto.hmac(:sha256, api_key(), encoded_body) |> Base.encode16)
  end

  defp secure_compare(request_key, expected_auth_key) do
    if(request_key == expected_auth_key, do: :ok)
  end

  defp redirect(:ok, conn) do
    conn
  end

  defp redirect(_, conn) do
    conn
    |> send_resp(400, "bad request")
    |> halt
  end

  defp api_key, do: Application.get_env(:nic_lan, :api_key)
end
