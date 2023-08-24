defmodule XBudgetBackendWeb.Router do
  use XBudgetBackendWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", XBudgetBackendWeb do
    pipe_through :api
  end
end
