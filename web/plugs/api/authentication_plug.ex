defmodule API.AuthenticationPlug do
  import Plug.Conn

  require Logger

  @auth_header_key "x-hub-signature"

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    with {:ok, request_auth_key}  <- get_key_to_digest(conn),
         {:ok, encoded_body}      <- Poison.encode(conn.body_params),
         {:ok, expected_auth_key} <- compute_hmac(encoded_body),
         {:ok}                    <- secure_compare(request_auth_key, expected_auth_key)
    do
      conn
    else
      _err -> redirect_bad_request(conn)
    end
  end

  defp get_key_to_digest(conn) do
    key_to_digest = get_req_header(conn, @auth_header_key) |> List.first

    case key_to_digest do
      nil -> {:error, Comeonin.Bcrypt.dummy_checkpw()}
      _   -> {:ok, key_to_digest}
    end
  end

  defp compute_hmac(encoded_body) do
    {:ok, "sha1=" <> hmac_by_text(encoded_body)}
  end

  defp hmac_by_text(text) do
    :crypto.hmac(:sha, api_key(), text) |> Base.encode16 |> String.downcase
  end

  defp secure_compare(request_key, expected_auth_key) do
    case request_key == expected_auth_key do
      true  -> {:ok}
      false -> {:error, Comeonin.Bcrypt.dummy_checkpw()}
    end
  end

  defp redirect_bad_request(conn) do
    conn
    |> send_resp(400, "bad request")
    |> halt
  end

  defp api_key, do: Application.get_env(:nic_lan, :api_key)
end
