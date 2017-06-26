defmodule NicLan.Router do
  use NicLan.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug API.AuthenticationPlug
  end

  scope "/", NicLan do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", as: :api do
    pipe_through :api

    scope "/posts", as: :posts do
      resources "/connect", API.Posts.ConnectController, only: [:create]
    end
  end
end
