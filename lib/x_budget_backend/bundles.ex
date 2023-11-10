defmodule XBudgetBackend.Bundles do
  @moduledoc """
  The Bundles context.
  """

  import Ecto.Query, warn: false
  alias XBudgetBackend.Repo

  alias XBudgetBackend.Bundles.Bundle

  @doc """
  Returns the list of bundles.

  ## Examples

      iex> list_bundles()
      [%Bundle{}, ...]

  """
  def list_bundles do
    Repo.all(Bundle)
  end

  @doc """
  Gets a single bundle.

  Raises `Ecto.NoResultsError` if the Bundle does not exist.

  ## Examples

      iex> get_bundle!(123)
      %Bundle{}

      iex> get_bundle!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bundle!(id), do: Repo.get!(Bundle, id)

  @doc """
  Creates a bundle.

  ## Examples

      iex> create_bundle(%{field: value})
      {:ok, %Bundle{}}

      iex> create_bundle(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bundle(attrs \\ %{}) do
    %Bundle{}
    |> Bundle.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bundle.

  ## Examples

      iex> update_bundle(bundle, %{field: new_value})
      {:ok, %Bundle{}}

      iex> update_bundle(bundle, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bundle(%Bundle{} = bundle, attrs) do
    bundle
    |> Bundle.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bundle.

  ## Examples

      iex> delete_bundle(bundle)
      {:ok, %Bundle{}}

      iex> delete_bundle(bundle)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bundle(%Bundle{} = bundle) do
    Repo.delete(bundle)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bundle changes.

  ## Examples

      iex> change_bundle(bundle)
      %Ecto.Changeset{data: %Bundle{}}

  """
  def change_bundle(%Bundle{} = bundle, attrs \\ %{}) do
    Bundle.changeset(bundle, attrs)
  end
end
