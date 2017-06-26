defmodule NicLan.API.Posts.ConnectControllerSpec do
  use ESpec.Phoenix, controller: NicLan.API.Posts.ConnectController, async: true

  let :hmac_hash, do: "whatever"

  let(:json_body) do
    File.read!("spec/fixtures/posts_connect_payload.json") |> Poison.decode!()
  end

  let :response do
    build_conn()
    |> put_req_header("x-hub-signature", hmac_hash())
    |> post("/api/posts/connect", json_body())
  end

  it "POST /api/posts/connect" do
    expect(response().status).to eq(401)
  end

  context "when a valid secret key is provided" do
    let :secret_key do
      Application.get_env(:nic_lan, :api_key)
    end

    let :hmac_hash do
      "sha1=" <> (:crypto.hmac(:sha256, secret_key, Poison.encode!(json_body())) |> Base.encode16)
    end

    it "POST /api/posts/connect" do
      expect(response().status).to eq(200)
    end
  end
end
