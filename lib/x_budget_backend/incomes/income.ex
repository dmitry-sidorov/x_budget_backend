defmodule XBudgetBackend.Incomes.Income do
  use Ecto.Schema
  import Ecto.Changeset

  schema "incomes" do
    field :description, :string
    field :income_date, :naive_datetime
    belongs_to :account, XBudgetBackend.Accounts.Account
    belongs_to :group, XBudgetBackend.Groups.Group

    timestamps()
  end

  @doc false
  def changeset(income, attrs) do
    income
    |> cast(attrs, [:description, :income_date])
    |> validate_required([:description, :income_date])
  end
end
