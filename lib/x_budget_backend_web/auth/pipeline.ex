defmodule XBudgetBackendWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :x_budget_backend,
    module: XBudgetBackendWeb.Auth.Guardian,
    error_handler: XBudgetBackendWeb.Auth.GuardianErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
