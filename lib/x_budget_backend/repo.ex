defmodule XBudgetBackend.Repo do
  use Ecto.Repo,
    otp_app: :x_budget_backend,
    adapter: Ecto.Adapters.Postgres
end
