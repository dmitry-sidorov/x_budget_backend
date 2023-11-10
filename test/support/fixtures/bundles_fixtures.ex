defmodule XBudgetBackend.BundlesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `XBudgetBackend.Bundles` context.
  """

  @doc """
  Generate a bundle.
  """
  def bundle_fixture(attrs \\ %{}) do
    {:ok, bundle} =
      attrs
      |> Enum.into(%{
        summary_amount: 120.5,
        amount_updated_at: ~N[2023-11-09 17:34:00],
        percentage: 120.5
      })
      |> XBudgetBackend.Bundles.create_bundle()

    bundle
  end
end
