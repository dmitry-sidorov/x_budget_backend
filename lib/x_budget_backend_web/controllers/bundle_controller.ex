defmodule XBudgetBackendWeb.BundleController do
  use XBudgetBackendWeb, :controller

  alias XBudgetBackend.Bundles
  alias XBudgetBackend.Bundles.Bundle

  action_fallback XBudgetBackendWeb.FallbackController

  def index(conn, _params) do
    bundles = Bundles.list_bundles()
    render(conn, :index, bundles: bundles)
  end

  def create(conn, %{"bundle" => bundle_params}) do
    with {:ok, %Bundle{} = bundle} <- Bundles.create_bundle(bundle_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/bundles/#{bundle}")
      |> render(:show, bundle: bundle)
    end
  end

  def show(conn, %{"id" => id}) do
    bundle = Bundles.get_bundle!(id)
    render(conn, :show, bundle: bundle)
  end

  def update(conn, %{"id" => id, "bundle" => bundle_params}) do
    bundle = Bundles.get_bundle!(id)

    with {:ok, %Bundle{} = bundle} <- Bundles.update_bundle(bundle, bundle_params) do
      render(conn, :show, bundle: bundle)
    end
  end

  def delete(conn, %{"id" => id}) do
    bundle = Bundles.get_bundle!(id)

    with {:ok, %Bundle{}} <- Bundles.delete_bundle(bundle) do
      send_resp(conn, :no_content, "")
    end
  end
end
