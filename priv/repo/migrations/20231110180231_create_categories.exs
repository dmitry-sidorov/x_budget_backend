defmodule XBudgetBackend.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :title, :string
      add :bundle_id, references(:bundles, on_delete: :nothing)
      add :group_id, references(:groups, on_delete: :delete_all)

      timestamps()
    end

    create index(:categories, [:bundle_id])
    create index(:categories, [:group_id])
  end
end
