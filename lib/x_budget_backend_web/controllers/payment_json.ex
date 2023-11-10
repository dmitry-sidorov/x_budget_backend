defmodule XBudgetBackendWeb.PaymentJSON do
  alias XBudgetBackend.Payments.Payment

  @doc """
  Renders a list of payments.
  """
  def index(%{payments: payments}) do
    %{data: for(payment <- payments, do: data(payment))}
  end

  @doc """
  Renders a single payment.
  """
  def show(%{payment: payment}) do
    %{data: data(payment)}
  end

  defp data(%Payment{} = payment) do
    %{
      id: payment.id,
      amount: payment.amount,
      currency: payment.currency,
      description: payment.description
    }
  end
end
