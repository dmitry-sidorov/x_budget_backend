defmodule XBudgetBackendWeb.Router do
  use XBudgetBackendWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", XBudgetBackendWeb do
    pipe_through :api
    get "/", DefaultController, :index
    post "/accounts/create", AccountController, :create
    # debug
    get "/accounts", AccountController, :index
    get "/users", UserController, :index
  end
end
