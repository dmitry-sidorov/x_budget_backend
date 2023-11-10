defmodule XBudgetBackend.InvoicesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `XBudgetBackend.Invoices` context.
  """

  @doc """
  Generate a invoice.
  """
  def invoice_fixture(attrs \\ %{}) do
    {:ok, invoice} =
      attrs
      |> Enum.into(%{
        description: "some description",
        amount: 120.5,
        invoice_date: ~N[2023-11-09 19:50:00]
      })
      |> XBudgetBackend.Invoices.create_invoice()

    invoice
  end
end
