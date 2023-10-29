defmodule XBudgetBackendWeb.CategoryJSON do
  alias XBudgetBackend.Categories.Category

  @doc """
  Renders a list of categories.
  """
  def index(%{categories: categories}) do
    %{data: for(category <- categories, do: data(category))}
  end

  @doc """
  Renders a single category.
  """
  def show(%{category: category}) do
    %{data: data(category)}
  end

  defp data(%Category{} = category) do
    %{
      id: category.id,
      title: category.title
    }
  end
end
