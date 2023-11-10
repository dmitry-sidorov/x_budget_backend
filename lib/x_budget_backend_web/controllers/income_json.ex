defmodule XBudgetBackendWeb.IncomeJSON do
  alias XBudgetBackend.Incomes.Income

  @doc """
  Renders a list of incomes.
  """
  def index(%{incomes: incomes}) do
    %{data: for(income <- incomes, do: data(income))}
  end

  @doc """
  Renders a single income.
  """
  def show(%{income: income}) do
    %{data: data(income)}
  end

  defp data(%Income{} = income) do
    %{
      id: income.id,
      description: income.description,
      income_date: income.income_date
    }
  end
end
