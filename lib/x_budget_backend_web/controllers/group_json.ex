defmodule XBudgetBackendWeb.GroupJSON do
  alias XBudgetBackendWeb.BundleJSON
  alias XBudgetBackend.Groups.Group

  @doc """
  Renders a list of groups.
  """
  def index(%{groups: groups}) do
    %{data: for(group <- groups, do: data(group))}
  end

  @doc """
  Renders a single group.
  """
  def show(%{group: group}) do
    %{data: data(group)}
  end

  defp data(%Group{} = group) do
    %{
      id: group.id,
      name: group.name,
      description: group.description
    }
  end

  def show_full(%{group: group}) do
    %{ data: bundles } = BundleJSON.index(%{bundles: group.bundle})
    data = Map.merge(data(group), %{ bundles: bundles })
    %{ data: data }
  end
end
