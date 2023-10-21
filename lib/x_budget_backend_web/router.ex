defmodule XBudgetBackendWeb.Router do
  use XBudgetBackendWeb, :router
  use Plug.ErrorHandler

  def handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  def handle_errors(conn, %{reason: %{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :auth do
    plug XBudgetBackendWeb.Auth.Pipeline
    plug XBudgetBackendWeb.Auth.SetAccount
  end

  scope "/api", XBudgetBackendWeb do
    pipe_through :api
    get "/", DefaultController, :index
    post "/accounts/create", AccountController, :create
    post "/accounts/sign_in", AccountController, :sign_in
    # debug
    get "/accounts", AccountController, :index
    get "/users", UserController, :index
  end

  scope "/api", XBudgetBackendWeb do
    pipe_through [:api, :auth]
    get "/accounts/by_id/:id", AccountController, :show
    get "/accounts/sign_out", AccountController, :sign_out
    get "/accounts/refresh_session", AccountController, :refresh_session
    post "/accounts/update", AccountController, :update
    put "/users/update", UserController, :update
  end
end
