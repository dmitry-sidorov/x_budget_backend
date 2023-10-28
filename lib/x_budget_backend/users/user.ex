defmodule XBudgetBackend.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @optional_fields [
    :id,
    :first_name,
    :last_name,
    :gender,
    :age,
    :inserted_at,
    :updated_at
  ]
  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :gender, :string
    field :age, :integer
    belongs_to :account, XBudgetBackend.Accounts.Account

    timestamps()
  end

  defp all_fields do
    __MODULE__.__schema__(:fields)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, all_fields())
    |> validate_required(all_fields() -- @optional_fields)
  end
end
