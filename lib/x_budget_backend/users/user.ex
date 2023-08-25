defmodule XBudgetBackend.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :gender, :string
    field :age, :integer
    belongs_to :account, XBudgetBackend.Accounts.Account

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:accound_id, :first_name, :last_name, :gender, :age])
    |> validate_required([:accound_id])
  end
end
