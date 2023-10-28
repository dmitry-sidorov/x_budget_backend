defmodule XBudgetBackend.Support.SchemaCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias Ecto.Changeset
      import XBudgetBackend.Support.SchemaCase
    end
  end

  defp get_random_integer, do: Enum.random(0..100)

  defp get_random_naive_datetime do
    get_random_integer()
    |> Faker.NaiveDateTime.backward
    |> NaiveDateTime.truncate(:second)
  end

  def valid_params(fields_with_types) do
    valid_value_by_type = %{
      id: fn -> get_random_integer() end,
      string: fn -> Faker.Lorem.word() end,
      naive_datetime: fn -> get_random_naive_datetime() end
    }

    for {field, type} <- fields_with_types, into: %{} do
      case field do
        :email -> {Atom.to_string(field), Faker.Internet.email()}
        _ -> {Atom.to_string(field), valid_value_by_type[type].()}
      end
    end
  end

  def invalid_params(fields_with_types) do
    invalid_value_by_type = %{
      id: fn -> get_random_naive_datetime() end,
      string: fn -> get_random_naive_datetime() end,
      naive_datetime: fn -> Faker.Lorem.word() end
    }

    for {field, type} <- fields_with_types, into: %{} do
      {Atom.to_string(field), invalid_value_by_type[type].()}
    end
  end
end
