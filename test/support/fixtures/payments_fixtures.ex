defmodule XBudgetBackend.PaymentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `XBudgetBackend.Payments` context.
  """

  @doc """
  Generate a payment.
  """
  def payment_fixture(attrs \\ %{}) do
    {:ok, payment} =
      attrs
      |> Enum.into(%{
        description: "some description",
        currency: "some currency",
        amount: 120.5
      })
      |> XBudgetBackend.Payments.create_payment()

    payment
  end
end
