defmodule XBudgetBackendWeb.DomainJSON do
  alias XBudgetBackend.Domains.Domain

  @doc """
  Renders a list of domains.
  """
  def index(%{domains: domains}) do
    %{data: for(domain <- domains, do: data(domain))}
  end

  @doc """
  Renders a single domain.
  """
  def show(%{domain: domain}) do
    %{data: data(domain)}
  end

  defp data(%Domain{} = domain) do
    %{
      id: domain.id,
      title: domain.title,
      percentage: domain.percentage
    }
  end
end
