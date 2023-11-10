defmodule XBudgetBackendWeb.IncomeController do
  use XBudgetBackendWeb, :controller

  alias XBudgetBackend.Incomes
  alias XBudgetBackend.Incomes.Income

  action_fallback XBudgetBackendWeb.FallbackController

  def index(conn, _params) do
    incomes = Incomes.list_incomes()
    render(conn, :index, incomes: incomes)
  end

  def create(conn, %{"income" => income_params}) do
    with {:ok, %Income{} = income} <- Incomes.create_income(income_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/incomes/#{income}")
      |> render(:show, income: income)
    end
  end

  def show(conn, %{"id" => id}) do
    income = Incomes.get_income!(id)
    render(conn, :show, income: income)
  end

  def update(conn, %{"id" => id, "income" => income_params}) do
    income = Incomes.get_income!(id)

    with {:ok, %Income{} = income} <- Incomes.update_income(income, income_params) do
      render(conn, :show, income: income)
    end
  end

  def delete(conn, %{"id" => id}) do
    income = Incomes.get_income!(id)

    with {:ok, %Income{}} <- Incomes.delete_income(income) do
      send_resp(conn, :no_content, "")
    end
  end
end
