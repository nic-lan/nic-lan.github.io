defmodule API.AuthenticationPlugSpec do
  use Phoenix.ConnTest
  use ESpec, async: true

  let(:json_body) do
    File.read!("spec/fixtures/posts_connect_payload.json") |> Poison.decode!()
  end

  let :test_connection do
    build_conn()
  end

  subject do
    API.AuthenticationPlug.call(test_connection(), %{})
  end

  it "is bad request" do
    expect(subject().status).to eq(400)
  end

  context "when 'x-hub-signature' is invalid" do
    let :x_hub_signature, do: "whatever"
    let :test_connection do
      build_conn() |> put_req_header("x-hub-signature", x_hub_signature())
    end

    it "is bad request" do
      expect(subject().status).to eq(400)
    end

    context "and when 'x-hub-signature' is valid" do
      let :api_key, do: Application.get_env(:nic_lan, :api_key)
      let :encoded_body, do: Poison.encode(json_body())
      let :hmac do
        :crypto.hmac(:sha, api_key(), encoded_body())
        |> Base.encode16
        |> String.downcase
      end

      let :x_hub_signature, do: "sha1=" <> hmac()

      it "is ok" do
        expect(subject().status).to eq(200)
      end
    end
  end
end
