defmodule XBudgetBackend.Domains.Domain do
  use Ecto.Schema
  import Ecto.Changeset

  schema "domains" do
    field :title, :string
    field :percentage, :float

    timestamps()
  end

  @doc false
  def changeset(domain, attrs) do
    domain
    |> cast(attrs, [:title, :percentage])
    |> validate_required([:title])
  end
end
