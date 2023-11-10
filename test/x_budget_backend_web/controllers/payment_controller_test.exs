defmodule XBudgetBackendWeb.PaymentControllerTest do
  use XBudgetBackendWeb.ConnCase

  import XBudgetBackend.PaymentsFixtures

  alias XBudgetBackend.Payments.Payment

  @create_attrs %{
    description: "some description",
    currency: "some currency",
    amount: 120.5
  }
  @update_attrs %{
    description: "some updated description",
    currency: "some updated currency",
    amount: 456.7
  }
  @invalid_attrs %{description: nil, currency: nil, amount: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all payments", %{conn: conn} do
      conn = get(conn, ~p"/api/payments")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create payment" do
    test "renders payment when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/payments", payment: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/payments/#{id}")

      assert %{
               "id" => ^id,
               "amount" => 120.5,
               "currency" => "some currency",
               "description" => "some description"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/payments", payment: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update payment" do
    setup [:create_payment]

    test "renders payment when data is valid", %{conn: conn, payment: %Payment{id: id} = payment} do
      conn = put(conn, ~p"/api/payments/#{payment}", payment: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/payments/#{id}")

      assert %{
               "id" => ^id,
               "amount" => 456.7,
               "currency" => "some updated currency",
               "description" => "some updated description"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, payment: payment} do
      conn = put(conn, ~p"/api/payments/#{payment}", payment: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete payment" do
    setup [:create_payment]

    test "deletes chosen payment", %{conn: conn, payment: payment} do
      conn = delete(conn, ~p"/api/payments/#{payment}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/payments/#{payment}")
      end
    end
  end

  defp create_payment(_) do
    payment = payment_fixture()
    %{payment: payment}
  end
end
