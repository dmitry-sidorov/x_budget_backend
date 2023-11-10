defmodule XBudgetBackend.Repo.Migrations.CreateIncomes do
  use Ecto.Migration

  def change do
    create table(:incomes) do
      add :description, :text
      add :income_date, :naive_datetime
      add :account_id, references(:accounts, on_delete: :nothing)
      add :group_id, references(:groups, on_delete: :nothing)

      timestamps()
    end

    create index(:incomes, [:account_id])
    create index(:incomes, [:group_id])
  end
end
