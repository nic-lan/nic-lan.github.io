defmodule API.AuthenticationPlugSpec do
  use Phoenix.ConnTest
  use ESpec, async: true

  let :hmac_hash, do: "whatever"

  let(:json_body) do
    File.read!("spec/fixtures/posts_connect_payload.json") |> Poison.decode!()
  end

  let :test_connection do
    build_conn()
    # |> put_req_header("x-hub-signature", hmac_hash())
  end

  subject do
    API.AuthenticationPlug.call(test_connection(), %{})
  end

  it "is bad request" do
    expect(subject().status).to eq(400)
  end

  # context "when a valid secret key is provided" do
  #   let :secret_key do
  #     Application.get_env(:nic_lan, :api_key)
  #   end
  #
  #   let :hmac_hash do
  #     "sha1=" <> (:crypto.hmac(:sha256, secret_key, Poison.encode!(json_body())) |> Base.encode16)
  #   end
  #
  #   it "POST /api/posts/connect" do
  #     expect(subject().status).to eq(200)
  #   end
  # end
end
