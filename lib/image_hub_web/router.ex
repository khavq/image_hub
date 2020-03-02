defmodule ImageHubWeb.Router do
  use ImageHubWeb, :router

  pipeline :auth do
    plug ImageHub.Accounts.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

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

  scope "/auth", ImageHubWeb do
    pipe_through([:browser])

    get("/:provider", AuthController, :request)
    get("/:provider/callback", AuthController, :callback)
    post("/:provider/callback", AuthController, :callback)
    post("/logout", AuthController, :delete)
  end

  scope "/", ImageHubWeb do
    pipe_through [:browser, :auth]

    get "/", PageController, :index


    # session
    get  "/login",  SessionController, :new
    get  "/logout", SessionController, :logout
    post "/login",  SessionController, :login
  end

  scope "/", ImageHubWeb do
    pipe_through [:browser, :auth, :ensure_auth]

    get "/protected", PageController, :protected
    resources "/users", UserController
    resources "/uploads", UploadController
  end

  # Other scopes may use custom stacks.
  # scope "/api", ImageHubWeb do
  #   pipe_through :api
  # end
end
