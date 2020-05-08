defmodule SmileWeb.Router do
  use SmileWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug SmileWeb.Plugs.LoadUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SmileWeb do
    pipe_through :browser

    get "/", UserController, :index
    resources "/users", UserController
    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", SmileWeb do
  #   pipe_through :api
  # end
end
