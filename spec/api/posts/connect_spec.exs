defmodule NicLan.API.Posts.ConnectControllerSpec do
  use ESpec.Phoenix, controller: NicLan.API.Posts.ConnectController, async: true

  it "POST /api/posts/connect" do
    post build_conn(), "/api/posts/connect"
  end
end
