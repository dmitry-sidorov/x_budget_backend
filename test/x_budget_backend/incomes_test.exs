defmodule XBudgetBackend.IncomesTest do
  use XBudgetBackend.DataCase

  alias XBudgetBackend.Incomes

  describe "incomes" do
    alias XBudgetBackend.Incomes.Income

    import XBudgetBackend.IncomesFixtures

    @invalid_attrs %{description: nil, income_date: nil}

    test "list_incomes/0 returns all incomes" do
      income = income_fixture()
      assert Incomes.list_incomes() == [income]
    end

    test "get_income!/1 returns the income with given id" do
      income = income_fixture()
      assert Incomes.get_income!(income.id) == income
    end

    test "create_income/1 with valid data creates a income" do
      valid_attrs = %{description: "some description", income_date: ~N[2023-11-09 19:35:00]}

      assert {:ok, %Income{} = income} = Incomes.create_income(valid_attrs)
      assert income.description == "some description"
      assert income.income_date == ~N[2023-11-09 19:35:00]
    end

    test "create_income/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Incomes.create_income(@invalid_attrs)
    end

    test "update_income/2 with valid data updates the income" do
      income = income_fixture()

      update_attrs = %{
        description: "some updated description",
        income_date: ~N[2023-11-10 19:35:00]
      }

      assert {:ok, %Income{} = income} = Incomes.update_income(income, update_attrs)
      assert income.description == "some updated description"
      assert income.income_date == ~N[2023-11-10 19:35:00]
    end

    test "update_income/2 with invalid data returns error changeset" do
      income = income_fixture()
      assert {:error, %Ecto.Changeset{}} = Incomes.update_income(income, @invalid_attrs)
      assert income == Incomes.get_income!(income.id)
    end

    test "delete_income/1 deletes the income" do
      income = income_fixture()
      assert {:ok, %Income{}} = Incomes.delete_income(income)
      assert_raise Ecto.NoResultsError, fn -> Incomes.get_income!(income.id) end
    end

    test "change_income/1 returns a income changeset" do
      income = income_fixture()
      assert %Ecto.Changeset{} = Incomes.change_income(income)
    end
  end
end
