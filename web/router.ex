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
  end

  scope "/", NicLan do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", as: :api do
    pipe_through :api
  end
end
