defmodule XBudgetBackendWeb.InvoiceControllerTest do
  use XBudgetBackendWeb.ConnCase

  import XBudgetBackend.InvoicesFixtures

  alias XBudgetBackend.Invoices.Invoice

  @create_attrs %{
    description: "some description",
    amount: 120.5,
    invoice_date: ~N[2023-11-09 19:50:00]
  }
  @update_attrs %{
    description: "some updated description",
    amount: 456.7,
    invoice_date: ~N[2023-11-10 19:50:00]
  }
  @invalid_attrs %{description: nil, amount: nil, invoice_date: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all invoices", %{conn: conn} do
      conn = get(conn, ~p"/api/invoices")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create invoice" do
    test "renders invoice when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/invoices", invoice: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/invoices/#{id}")

      assert %{
               "id" => ^id,
               "amount" => 120.5,
               "description" => "some description",
               "invoice_date" => "2023-11-09T19:50:00"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/invoices", invoice: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update invoice" do
    setup [:create_invoice]

    test "renders invoice when data is valid", %{conn: conn, invoice: %Invoice{id: id} = invoice} do
      conn = put(conn, ~p"/api/invoices/#{invoice}", invoice: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/invoices/#{id}")

      assert %{
               "id" => ^id,
               "amount" => 456.7,
               "description" => "some updated description",
               "invoice_date" => "2023-11-10T19:50:00"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, invoice: invoice} do
      conn = put(conn, ~p"/api/invoices/#{invoice}", invoice: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete invoice" do
    setup [:create_invoice]

    test "deletes chosen invoice", %{conn: conn, invoice: invoice} do
      conn = delete(conn, ~p"/api/invoices/#{invoice}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/invoices/#{invoice}")
      end
    end
  end

  defp create_invoice(_) do
    invoice = invoice_fixture()
    %{invoice: invoice}
  end
end
