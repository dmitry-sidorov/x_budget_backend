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
        title: "test",
        description: "some description",
        percentage: 120.5
      })
      |> XBudgetBackend.Bundles.create_bundle()

    bundle
  end
end
