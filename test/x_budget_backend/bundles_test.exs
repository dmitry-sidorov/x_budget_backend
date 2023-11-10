defmodule XBudgetBackend.BundlesTest do
  use XBudgetBackend.DataCase

  alias XBudgetBackend.Bundles

  describe "bundles" do
    alias XBudgetBackend.Bundles.Bundle

    import XBudgetBackend.BundlesFixtures

    @invalid_attrs %{summary_amount: nil, amount_updated_at: nil, percentage: nil}

    test "list_bundles/0 returns all bundles" do
      bundle = bundle_fixture()
      assert Bundles.list_bundles() == [bundle]
    end

    test "get_bundle!/1 returns the bundle with given id" do
      bundle = bundle_fixture()
      assert Bundles.get_bundle!(bundle.id) == bundle
    end

    test "create_bundle/1 with valid data creates a bundle" do
      valid_attrs = %{summary_amount: 120.5, amount_updated_at: ~N[2023-11-09 17:34:00], percentage: 120.5}

      assert {:ok, %Bundle{} = bundle} = Bundles.create_bundle(valid_attrs)
      assert bundle.summary_amount == 120.5
      assert bundle.amount_updated_at == ~N[2023-11-09 17:34:00]
      assert bundle.percentage == 120.5
    end

    test "create_bundle/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bundles.create_bundle(@invalid_attrs)
    end

    test "update_bundle/2 with valid data updates the bundle" do
      bundle = bundle_fixture()
      update_attrs = %{summary_amount: 456.7, amount_updated_at: ~N[2023-11-10 17:34:00], percentage: 456.7}

      assert {:ok, %Bundle{} = bundle} = Bundles.update_bundle(bundle, update_attrs)
      assert bundle.summary_amount == 456.7
      assert bundle.amount_updated_at == ~N[2023-11-10 17:34:00]
      assert bundle.percentage == 456.7
    end

    test "update_bundle/2 with invalid data returns error changeset" do
      bundle = bundle_fixture()
      assert {:error, %Ecto.Changeset{}} = Bundles.update_bundle(bundle, @invalid_attrs)
      assert bundle == Bundles.get_bundle!(bundle.id)
    end

    test "delete_bundle/1 deletes the bundle" do
      bundle = bundle_fixture()
      assert {:ok, %Bundle{}} = Bundles.delete_bundle(bundle)
      assert_raise Ecto.NoResultsError, fn -> Bundles.get_bundle!(bundle.id) end
    end

    test "change_bundle/1 returns a bundle changeset" do
      bundle = bundle_fixture()
      assert %Ecto.Changeset{} = Bundles.change_bundle(bundle)
    end
  end
end
