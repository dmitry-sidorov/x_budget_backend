defmodule XBudgetBackendWeb.DomainController do
  use XBudgetBackendWeb, :controller

  alias XBudgetBackend.Domains
  alias XBudgetBackend.Domains.Domain

  action_fallback XBudgetBackendWeb.FallbackController

  def index(conn, _params) do
    domains = Domains.list_domains()
    render(conn, :index, domains: domains)
  end

  def create(conn, %{"domain" => domain_params}) do
    with {:ok, %Domain{} = domain} <- Domains.create_domain(domain_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/domains/#{domain}")
      |> render(:show, domain: domain)
    end
  end

  def show(conn, %{"id" => id}) do
    domain = Domains.get_domain!(id)
    render(conn, :show, domain: domain)
  end

  def update(conn, %{"id" => id, "domain" => domain_params}) do
    domain = Domains.get_domain!(id)

    with {:ok, %Domain{} = domain} <- Domains.update_domain(domain, domain_params) do
      render(conn, :show, domain: domain)
    end
  end

  def delete(conn, %{"id" => id}) do
    domain = Domains.get_domain!(id)

    with {:ok, %Domain{}} <- Domains.delete_domain(domain) do
      send_resp(conn, :no_content, "")
    end
  end
end
