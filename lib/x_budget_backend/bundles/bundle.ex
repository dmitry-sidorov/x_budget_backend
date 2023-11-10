defmodule XBudgetBackend.Bundles.Bundle do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bundles" do
    field :summary_amount, :float
    field :amount_updated_at, :naive_datetime
    field :percentage, :float
    belongs_to :group, XBudgetBackend.Groups.Group
    has_many :category, XBudgetBackend.Categories.Category

    timestamps()
  end

  @doc false
  def changeset(bundle, attrs) do
    bundle
    |> cast(attrs, [:summary_amount, :amount_updated_at, :percentage])
    |> validate_required([:percentage])
  end
end
