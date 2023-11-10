defmodule XBudgetBackend.IncomesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `XBudgetBackend.Incomes` context.
  """

  @doc """
  Generate a income.
  """
  def income_fixture(attrs \\ %{}) do
    {:ok, income} =
      attrs
      |> Enum.into(%{
        description: "some description",
        income_date: ~N[2023-11-09 19:35:00]
      })
      |> XBudgetBackend.Incomes.create_income()

    income
  end
end
