defmodule XBudgetBackend.InvoicesTest do
  use XBudgetBackend.DataCase

  alias XBudgetBackend.Invoices

  describe "invoices" do
    alias XBudgetBackend.Invoices.Invoice

    import XBudgetBackend.InvoicesFixtures

    @invalid_attrs %{description: nil, amount: nil, invoice_date: nil}

    test "list_invoices/0 returns all invoices" do
      invoice = invoice_fixture()
      assert Invoices.list_invoices() == [invoice]
    end

    test "get_invoice!/1 returns the invoice with given id" do
      invoice = invoice_fixture()
      assert Invoices.get_invoice!(invoice.id) == invoice
    end

    test "create_invoice/1 with valid data creates a invoice" do
      valid_attrs = %{description: "some description", amount: 120.5, invoice_date: ~N[2023-11-09 19:50:00]}

      assert {:ok, %Invoice{} = invoice} = Invoices.create_invoice(valid_attrs)
      assert invoice.description == "some description"
      assert invoice.amount == 120.5
      assert invoice.invoice_date == ~N[2023-11-09 19:50:00]
    end

    test "create_invoice/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Invoices.create_invoice(@invalid_attrs)
    end

    test "update_invoice/2 with valid data updates the invoice" do
      invoice = invoice_fixture()
      update_attrs = %{description: "some updated description", amount: 456.7, invoice_date: ~N[2023-11-10 19:50:00]}

      assert {:ok, %Invoice{} = invoice} = Invoices.update_invoice(invoice, update_attrs)
      assert invoice.description == "some updated description"
      assert invoice.amount == 456.7
      assert invoice.invoice_date == ~N[2023-11-10 19:50:00]
    end

    test "update_invoice/2 with invalid data returns error changeset" do
      invoice = invoice_fixture()
      assert {:error, %Ecto.Changeset{}} = Invoices.update_invoice(invoice, @invalid_attrs)
      assert invoice == Invoices.get_invoice!(invoice.id)
    end

    test "delete_invoice/1 deletes the invoice" do
      invoice = invoice_fixture()
      assert {:ok, %Invoice{}} = Invoices.delete_invoice(invoice)
      assert_raise Ecto.NoResultsError, fn -> Invoices.get_invoice!(invoice.id) end
    end

    test "change_invoice/1 returns a invoice changeset" do
      invoice = invoice_fixture()
      assert %Ecto.Changeset{} = Invoices.change_invoice(invoice)
    end
  end
end
