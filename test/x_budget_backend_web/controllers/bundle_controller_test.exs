defmodule XBudgetBackendWeb.BundleControllerTest do
  use XBudgetBackendWeb.ConnCase

  import XBudgetBackend.BundlesFixtures

  alias XBudgetBackend.Bundles.Bundle

  @create_attrs %{
    summary_amount: 120.5,
    amount_updated_at: ~N[2023-11-09 17:34:00],
    percentage: 120.5
  }
  @update_attrs %{
    summary_amount: 456.7,
    amount_updated_at: ~N[2023-11-10 17:34:00],
    percentage: 456.7
  }
  @invalid_attrs %{summary_amount: nil, amount_updated_at: nil, percentage: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all bundles", %{conn: conn} do
      conn = get(conn, ~p"/api/bundles")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create bundle" do
    test "renders bundle when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/bundles", bundle: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/bundles/#{id}")

      assert %{
               "id" => ^id,
               "amount_updated_at" => "2023-11-09T17:34:00",
               "percentage" => 120.5,
               "summary_amount" => 120.5
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/bundles", bundle: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update bundle" do
    setup [:create_bundle]

    test "renders bundle when data is valid", %{conn: conn, bundle: %Bundle{id: id} = bundle} do
      conn = put(conn, ~p"/api/bundles/#{bundle}", bundle: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/bundles/#{id}")

      assert %{
               "id" => ^id,
               "amount_updated_at" => "2023-11-10T17:34:00",
               "percentage" => 456.7,
               "summary_amount" => 456.7
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, bundle: bundle} do
      conn = put(conn, ~p"/api/bundles/#{bundle}", bundle: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete bundle" do
    setup [:create_bundle]

    test "deletes chosen bundle", %{conn: conn, bundle: bundle} do
      conn = delete(conn, ~p"/api/bundles/#{bundle}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/bundles/#{bundle}")
      end
    end
  end

  defp create_bundle(_) do
    bundle = bundle_fixture()
    %{bundle: bundle}
  end
end
