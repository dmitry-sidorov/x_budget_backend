defmodule XBudgetBackend.Domains.Domain do
  use Ecto.Schema
  import Ecto.Changeset
  alias XBudgetBackend.Categories.Category

  schema "domains" do
    field :title, :string
    field :percentage, :float
    has_many :category, Category

    timestamps()
  end

  @doc false
  def changeset(domain, attrs) do
    domain
    |> cast(attrs, [:title, :percentage])
    |> validate_required([:title, :percentage])
  end
end
