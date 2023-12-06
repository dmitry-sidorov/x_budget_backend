defmodule XBudgetBackend.Repo.Migrations.CreateBundles do
  use Ecto.Migration

  def change do
    create table(:bundles) do
      add :title, :string
      add :description, :text
      add :percentage, :float
      add :group_id, references(:groups, on_delete: :delete_all)

      timestamps()
    end

    create index(:bundles, [:group_id])
  end
end
