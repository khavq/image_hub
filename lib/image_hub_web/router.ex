defmodule ImageHubWeb.Router do
  use ImageHubWeb, :router

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

  scope "/", ImageHubWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/users", ImageHubWeb.UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", ImageHubWeb do
  #   pipe_through :api
  # end
end
