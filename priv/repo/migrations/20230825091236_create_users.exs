defmodule XBudgetBackend.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :gender, :string
      add :birthdate, :naive_datetime
      add :account_id, references(:accounts, on_delete: :delete_all)

      timestamps()
    end

    create index(:users, [:account_id])
  end
end
