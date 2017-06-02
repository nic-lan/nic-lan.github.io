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
end
