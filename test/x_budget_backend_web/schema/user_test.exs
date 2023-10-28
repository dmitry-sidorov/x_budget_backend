defmodule XBudgetBackend.Schema.UserTest do
  use XBudgetBackend.Support.SchemaCase
  alias XBudgetBackend.Users.User

  @expected_fields_with_types [
    {:id, :id},
    {:first_name, :string},
    {:last_name, :string},
    {:gender, :string},
    {:age, :integer},
    {:account_id, :id},
    {:inserted_at, :naive_datetime},
    {:updated_at, :naive_datetime},
  ]

  @optional_fields [
    :id,
    :first_name,
    :last_name,
    :gender,
    :age,
    :inserted_at,
    :updated_at
  ]

  describe "user fields and types" do
    test "user has correct fields and types" do
      actual_fields_with_types =
        for field <- User.__schema__(:fields) do
          type = User.__schema__(:type, field)
          {field, type}
        end

      assert MapSet.new(actual_fields_with_types) == MapSet.new(@expected_fields_with_types)
    end
  end

  describe "changeset/2" do
    test "success: returns a valid changeset when valid arguments given" do
      valid_params = valid_params(@expected_fields_with_types)

      changeset = User.changeset(%User{}, valid_params)

      assert %Changeset{valid?: true, changes: changes} = changeset

      for {field, _} <- @expected_fields_with_types do
        actual = Map.get(changes, field)
        expected = valid_params[Atom.to_string(field)]

        assert actual == expected,
          "Values did not match for field: #{field}/nexpected: #{inspect(expected)}\nactual: #{inspect(actual)}"
      end
    end

    test "error: returns an error changeset when uncastable values given" do
      invalid_params = invalid_params(@expected_fields_with_types)

      assert %Changeset{valid?: false, errors: errors} = User.changeset(%User{}, invalid_params)

      for {field, _} <- @expected_fields_with_types do
        assert errors[field], "The field #{field} is missing from errors."

        {_, meta} = errors[field]
        assert meta[:validation] == :cast, "The validation type, #{meta[:validation]}, is incorrect for field #{field}"
      end
    end

    test "error: returns an error changeset when required fields are missing" do
      assert %Changeset{valid?: false, errors: errors} = User.changeset(%User{}, %{})

      for {field, _} <- @expected_fields_with_types, field not in @optional_fields do
        assert errors[field], "The field #{field} is missing from errors."

        {_, meta} = errors[field]
        assert meta[:validation] == :required, "The validation type, #{meta[:validation]}, is incorrect for field #{field}"
      end

      for field <- @optional_fields do
        refute errors[field], "The optional field #{field} is required when it shouldn't be."
      end
    end

  end
end
