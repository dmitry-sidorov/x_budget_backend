defmodule XBudgetBackend.CategoriesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `XBudgetBackend.Categories` context.
  """

  @doc """
  Generate a category.
  """
  def category_fixture(attrs \\ %{}) do
    {:ok, category} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> XBudgetBackend.Categories.create_category()

    category
  end
end
