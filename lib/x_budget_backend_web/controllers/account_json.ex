defmodule XBudgetBackendWeb.AccountJSON do
  alias XBudgetBackend.{Accounts.Account}
  alias XBudgetBackendWeb.UserJSON

  @doc """
  Renders a list of accounts.
  """
  def index(%{accounts: accounts}) do
    %{data: for(account <- accounts, do: data(account))}
  end

  @doc """
  Renders a single account.
  """
  def show(%{account: account}) do
    %{data: data(account)}
  end

  def show_full_account(%{account: account}) do
    %{
      id: account.id,
      email: account.email,
      user: UserJSON.show(%{ user: account.user })
    }
  end

  def account_token(%{account: account, token: token}) do
    %{
      id: account.id,
      email: account.email,
      token: token
    }
  end

  defp data(%Account{} = account) do
    %{
      id: account.id,
      email: account.email,
      hashed_password: account.hashed_password
    }
  end
end
