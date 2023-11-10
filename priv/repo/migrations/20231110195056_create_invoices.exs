defmodule XBudgetBackend.Repo.Migrations.CreateInvoices do
  use Ecto.Migration

  def change do
    create table(:invoices) do
      add :description, :text
      add :amount, :float
      add :invoice_date, :naive_datetime
      add :account_id, references(:accounts, on_delete: :nothing)
      add :category_id, references(:categories, on_delete: :nothing)

      timestamps()
    end

    create index(:invoices, [:account_id])
    create index(:invoices, [:category_id])
  end
end
