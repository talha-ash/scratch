defmodule ScratchWeb.Router do
  use ScratchWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end



  scope "/api", ScratchWeb do
    pipe_through :api
  end

  pipeline :auth_api do
    plug :accepts, ["json"]

    plug Guardian.Plug.Pipeline,
      module: Scratch.Guardian,
      error_handler: Scratch.AuthErrorHandler

    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.LoadResource
  end

  pipeline :graphql do
    plug ScratchWeb.Context
  end

  scope "/api/v1" do
    post "/login", ScratchWeb.AuthController, :login
    pipe_through :graphql
    # post "/register", AuthController, :register
    post("/", Absinthe.Plug, schema: ScratchWeb.Schema)
    forward("/graphiql", Absinthe.Plug.GraphiQL, schema: ScratchWeb.Schema)
    # pipe_through :auth_api
    # resources "/users", UserController, except: [:create]
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    # forward("/graphiql", Absinthe.Plug.GraphiQL, schema: ScratchWeb.Schema)

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: ScratchWeb.Telemetry
    end
  end
end
