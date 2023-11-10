defmodule XBudgetBackendWeb.IncomeControllerTest do
  use XBudgetBackendWeb.ConnCase

  import XBudgetBackend.IncomesFixtures

  alias XBudgetBackend.Incomes.Income

  @create_attrs %{
    description: "some description",
    income_date: ~N[2023-11-09 19:35:00]
  }
  @update_attrs %{
    description: "some updated description",
    income_date: ~N[2023-11-10 19:35:00]
  }
  @invalid_attrs %{description: nil, income_date: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all incomes", %{conn: conn} do
      conn = get(conn, ~p"/api/incomes")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create income" do
    test "renders income when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/incomes", income: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/incomes/#{id}")

      assert %{
               "id" => ^id,
               "description" => "some description",
               "income_date" => "2023-11-09T19:35:00"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/incomes", income: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update income" do
    setup [:create_income]

    test "renders income when data is valid", %{conn: conn, income: %Income{id: id} = income} do
      conn = put(conn, ~p"/api/incomes/#{income}", income: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/incomes/#{id}")

      assert %{
               "id" => ^id,
               "description" => "some updated description",
               "income_date" => "2023-11-10T19:35:00"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, income: income} do
      conn = put(conn, ~p"/api/incomes/#{income}", income: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete income" do
    setup [:create_income]

    test "deletes chosen income", %{conn: conn, income: income} do
      conn = delete(conn, ~p"/api/incomes/#{income}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/incomes/#{income}")
      end
    end
  end

  defp create_income(_) do
    income = income_fixture()
    %{income: income}
  end
end
