defmodule XBudgetBackendWeb.InvoiceJSON do
  alias XBudgetBackend.Invoices.Invoice

  @doc """
  Renders a list of invoices.
  """
  def index(%{invoices: invoices}) do
    %{data: for(invoice <- invoices, do: data(invoice))}
  end

  @doc """
  Renders a single invoice.
  """
  def show(%{invoice: invoice}) do
    %{data: data(invoice)}
  end

  defp data(%Invoice{} = invoice) do
    %{
      id: invoice.id,
      description: invoice.description,
      amount: invoice.amount,
      invoice_date: invoice.invoice_date
    }
  end
end
