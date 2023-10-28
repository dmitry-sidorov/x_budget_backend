defmodule XBudgetBackend.DomainsTest do
  use XBudgetBackend.DataCase

  alias XBudgetBackend.Domains

  describe "domains" do
    alias XBudgetBackend.Domains.Domain

    import XBudgetBackend.DomainsFixtures

    @invalid_attrs %{title: nil, percentage: nil}

    test "list_domains/0 returns all domains" do
      domain = domain_fixture()
      assert Domains.list_domains() == [domain]
    end

    test "get_domain!/1 returns the domain with given id" do
      domain = domain_fixture()
      assert Domains.get_domain!(domain.id) == domain
    end

    test "create_domain/1 with valid data creates a domain" do
      valid_attrs = %{title: "some title", percentage: 120.5}

      assert {:ok, %Domain{} = domain} = Domains.create_domain(valid_attrs)
      assert domain.title == "some title"
      assert domain.percentage == 120.5
    end

    test "create_domain/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Domains.create_domain(@invalid_attrs)
    end

    test "update_domain/2 with valid data updates the domain" do
      domain = domain_fixture()
      update_attrs = %{title: "some updated title", percentage: 456.7}

      assert {:ok, %Domain{} = domain} = Domains.update_domain(domain, update_attrs)
      assert domain.title == "some updated title"
      assert domain.percentage == 456.7
    end

    test "update_domain/2 with invalid data returns error changeset" do
      domain = domain_fixture()
      assert {:error, %Ecto.Changeset{}} = Domains.update_domain(domain, @invalid_attrs)
      assert domain == Domains.get_domain!(domain.id)
    end

    test "delete_domain/1 deletes the domain" do
      domain = domain_fixture()
      assert {:ok, %Domain{}} = Domains.delete_domain(domain)
      assert_raise Ecto.NoResultsError, fn -> Domains.get_domain!(domain.id) end
    end

    test "change_domain/1 returns a domain changeset" do
      domain = domain_fixture()
      assert %Ecto.Changeset{} = Domains.change_domain(domain)
    end
  end
end
