defmodule XBudgetBackend.Categories.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias XBudgetBackend.{Domains.Domain, Payments.Payment}

  schema "categories" do
    field :title, :string
    belongs_to :domain, Domain
    has_many :payment, Payment

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
