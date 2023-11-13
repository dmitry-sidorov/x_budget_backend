defmodule XBudgetBackend.Bundles.Bundle do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bundles" do
    field :title, :string
    field :description, :string
    field :percentage, :float
    belongs_to :group, XBudgetBackend.Groups.Group
    has_many :category, XBudgetBackend.Categories.Category

    timestamps()
  end

  @doc false
  def changeset(bundle, attrs) do
    bundle
    |> cast(attrs, [:title, :description, :percentage])
    |> validate_required([:title, :percentage])
  end
end
