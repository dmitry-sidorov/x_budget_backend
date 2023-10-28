defmodule XBudgetBackend.Payments.Payment do
  use Ecto.Schema
  import Ecto.Changeset
  alias XBudgetBackend.{Accounts.Account, Categories.Category}

  schema "payments" do
    field :description, :string
    field :currency, :string
    field :amount, :float
    belongs_to :account, Account
    belongs_to :category, Category

    timestamps()
  end

  @doc false
  def changeset(payment, attrs) do
    payment
    |> cast(attrs, [:amount, :currency, :description])
    |> validate_required([:amount, :currency, :description])
  end
end
