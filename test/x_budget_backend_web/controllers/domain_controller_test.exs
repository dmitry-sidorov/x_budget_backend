defmodule XBudgetBackendWeb.DomainControllerTest do
  use XBudgetBackendWeb.ConnCase

  import XBudgetBackend.DomainsFixtures

  alias XBudgetBackend.Domains.Domain

  @create_attrs %{
    title: "some title",
    percentage: 120.5
  }
  @update_attrs %{
    title: "some updated title",
    percentage: 456.7
  }
  @invalid_attrs %{title: nil, percentage: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all domains", %{conn: conn} do
      conn = get(conn, ~p"/api/domains")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create domain" do
    test "renders domain when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/domains", domain: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/domains/#{id}")

      assert %{
               "id" => ^id,
               "percentage" => 120.5,
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/domains", domain: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update domain" do
    setup [:create_domain]

    test "renders domain when data is valid", %{conn: conn, domain: %Domain{id: id} = domain} do
      conn = put(conn, ~p"/api/domains/#{domain}", domain: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/domains/#{id}")

      assert %{
               "id" => ^id,
               "percentage" => 456.7,
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, domain: domain} do
      conn = put(conn, ~p"/api/domains/#{domain}", domain: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete domain" do
    setup [:create_domain]

    test "deletes chosen domain", %{conn: conn, domain: domain} do
      conn = delete(conn, ~p"/api/domains/#{domain}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/domains/#{domain}")
      end
    end
  end

  defp create_domain(_) do
    domain = domain_fixture()
    %{domain: domain}
  end
end
