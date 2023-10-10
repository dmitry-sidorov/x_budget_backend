defmodule XBudgetBackendWeb.Auth.Guardian do
  use Guardian, otp_app: :x_budget_backend
  alias XBudgetBackend.Accounts

  def subject_for_token(%{id: id}, _claims), do: {:ok, to_string(id)}

  def subject_for_token(_, _), do: {:error, :no_id_provided}

  def resource_from_claims(%{"sub" => id}) do
    case Accounts.get_account!(id) do
      nil -> {:error, :not_found}
      resource -> {:ok, resource}
    end
  end

  def resource_from_claims(_claims) do
    {:error, :no_id_provided}
  end


  def authenticate(email, password) do
    case Accounts.get_account_by_email(email) do
      nil -> {:error, :unauthorized}
      account ->
        case validate_password(password, account.hashed_password) do
          true -> create_token(account)
          false -> {:error, :unauthorized}
        end
      end
    end

    defp validate_password(password, hashed_password) do
      Bcrypt.verify_pass(password, hashed_password)
    end

    defp create_token(account) do
      {:ok, token, _claims} = encode_and_sign(account)
      {:ok, account, token}
    end

    def after_encode_and_sign(resource, claims, token, _options) do
      with {:ok, _} <- Guardian.DB.after_encode_and_sign(resource, claims["typ"], claims, token) do
        {:ok, token}
      end
    end

    def on_verify(claims, token, _options) do
      with {:ok, _} <- Guardian.DB.on_verify(claims, token) do
        {:ok, claims}
      end
    end

    def on_revoke(claims, token, _options) do
      with {:ok, _} <- Guardian.DB.on_revoke(claims, token) do
        {:ok, claims}
      end
    end
  end
