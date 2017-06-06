defmodule NicLan.API.Posts.ConnectControllerSpec do
  use ESpec.Phoenix, controller: NicLan.API.Posts.ConnectController, async: true

  let :secret_key, do: "whatever"

  let :response do
    build_conn()
    |> put_req_header("authorization", secret_key())
    |> post("/api/posts/connect")
  end

  it "POST /api/posts/connect" do
    expect(response().status).to eq(401)
  end

  context "when a valid secret key is provided" do
    let :secret_key, do: Application.get_env(:nic_lan, :api_key)

    it "POST /api/posts/connect" do
      expect(response().status).to eq(200)
    end
  end
end
