defmodule XBudgetBackend.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :title, :string
      add :domain_id, references(:domains, on_delete: :nothing)

      timestamps()
    end

    create index(:categories, [:domain_id])
  end
end
