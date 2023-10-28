defmodule XBudgetBackend.Repo.Migrations.CreatePayments do
  use Ecto.Migration

  def change do
    create table(:payments) do
      add :amount, :float
      add :currency, :string
      add :description, :text
      add :account_id, references(:accounts, on_delete: :nothing)
      add :category_id, references(:categories, on_delete: :nothing)

      timestamps()
    end

    create index(:payments, [:account_id])
    create index(:payments, [:category_id])
  end
end
