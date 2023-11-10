defmodule XBudgetBackend.Repo.Migrations.CreateGroups do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :name, :string
      add :description, :text

      timestamps()
    end
  end
end
