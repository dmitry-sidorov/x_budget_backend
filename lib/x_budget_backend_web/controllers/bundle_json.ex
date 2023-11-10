defmodule XBudgetBackendWeb.BundleJSON do
  alias XBudgetBackend.Bundles.Bundle

  @doc """
  Renders a list of bundles.
  """
  def index(%{bundles: bundles}) do
    %{data: for(bundle <- bundles, do: data(bundle))}
  end

  @doc """
  Renders a single bundle.
  """
  def show(%{bundle: bundle}) do
    %{data: data(bundle)}
  end

  defp data(%Bundle{} = bundle) do
    %{
      id: bundle.id,
      summary_amount: bundle.summary_amount,
      amount_updated_at: bundle.amount_updated_at,
      percentage: bundle.percentage
    }
  end
end
