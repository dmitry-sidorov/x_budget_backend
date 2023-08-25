defmodule XBudgetBackend.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `XBudgetBackend.Accounts` context.
  """

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    {:ok, account} =
      attrs
      |> Enum.into(%{
        email: "some email",
        hashed_password: "some hashed_password"
      })
      |> XBudgetBackend.Accounts.create_account()

    account
  end
end
