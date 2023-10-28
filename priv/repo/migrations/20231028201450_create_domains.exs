defmodule XBudgetBackend.Repo.Migrations.CreateDomains do
  use Ecto.Migration

  def change do
    create table(:domains) do
      add :title, :string
      add :percentage, :float

      timestamps()
    end
  end
end
