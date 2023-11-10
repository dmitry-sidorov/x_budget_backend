defmodule XBudgetBackend.Invoices.Invoice do
  use Ecto.Schema
  import Ecto.Changeset

  schema "invoices" do
    field :description, :string
    field :amount, :float
    field :invoice_date, :naive_datetime
    belongs_to :account, XBudgetBackend.Accounts.Account
    belongs_to :category, XBudgetBackend.Categories.Category

    timestamps()
  end

  @doc false
  def changeset(invoice, attrs) do
    invoice
    |> cast(attrs, [:description, :amount, :invoice_date])
    |> validate_required([:description, :amount, :invoice_date])
  end
end
