defmodule XBudgetBackend.Schema.AccountTest do
  use ExUnit.Case
  alias XBudgetBackend.Accounts.Account

  @expected_fields_with_types [
    {:id, :id},
    {:email, :string},
    {:hashed_password, :string},
    {:inserted_at, :naive_datetime},
    {:updated_at, :naive_datetime},
  ]

  describe "Account fields and types" do
    test "Account has correct fields and types" do
      actual_fields_with_types =
        for field <- Account.__schema__(:fields) do
          type = Account.__schema__(:type, field)
          {field, type}
        end

      assert MapSet.new(actual_fields_with_types) == MapSet.new(@expected_fields_with_types)
    end

  end

end
