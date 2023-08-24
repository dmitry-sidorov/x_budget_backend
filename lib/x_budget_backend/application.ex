defmodule XBudgetBackend.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      XBudgetBackendWeb.Telemetry,
      # Start the Ecto repository
      XBudgetBackend.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: XBudgetBackend.PubSub},
      # Start the Endpoint (http/https)
      XBudgetBackendWeb.Endpoint
      # Start a worker by calling: XBudgetBackend.Worker.start_link(arg)
      # {XBudgetBackend.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: XBudgetBackend.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    XBudgetBackendWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
