defmodule XBudgetBackend.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :email, :string
      add :hashed_password, :string

      timestamps()
    end
  end
end
