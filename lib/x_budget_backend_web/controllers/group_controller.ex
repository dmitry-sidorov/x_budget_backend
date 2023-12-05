defmodule XBudgetBackendWeb.GroupController do
  use XBudgetBackendWeb, :controller

  alias XBudgetBackend.{Categories, Bundles, Groups, Groups.Group}

  action_fallback XBudgetBackendWeb.FallbackController

  def index(conn, _params) do
    groups = Groups.list_groups()
    render(conn, :index, groups: groups)
  end

  def create(conn, %{"group" => group_params}) do
    with {:ok, %Group{} = group} <- Groups.create_group(group_params) do
      conn
      |> put_status(:created)
      |> render(:show, group: group)
    end
  end

  def create_default(conn, %{"name" => name}) do
    with {:ok, %Group{} = group} <- Groups.create_group(%{name: name}) do
      Bundles.create_default_bundles(group)
      full_group = Groups.get_full_group!(group.id)
      Categories.create_default_categories(full_group.bundle)

      conn
      |> put_status(:created)
      |> render(:show_full, group: full_group)
    end
  end

  @spec show_full_group(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def show_full_group(conn, %{"id" => id}) do
    group = Groups.get_full_group!(id)
    render(conn, :show_full, group: group)
  end

  @spec show(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    group = Groups.get_group!(id)
    render(conn, :show, group: group)
  end

  def update(conn, %{"id" => id, "group" => group_params}) do
    group = Groups.get_group!(id)

    with {:ok, %Group{} = group} <- Groups.update_group(group, group_params) do
      render(conn, :show, group: group)
    end
  end

  def delete(conn, %{"id" => id}) do
    group = Groups.get_group!(id)

    with {:ok, %Group{}} <- Groups.delete_group(group) do
      send_resp(conn, :no_content, "")
    end
  end
end
