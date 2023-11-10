defmodule XBudgetBackend.Groups.Group do
  use Ecto.Schema
  import Ecto.Changeset

  schema "groups" do
    field :name, :string
    field :description, :string
    has_many :bundle, XBudgetBackend.Bundles.Bundle
    has_many :category, XBudgetBackend.Categories.Category

    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:name, :description])
    |> validate_required([:name])
  end
end
