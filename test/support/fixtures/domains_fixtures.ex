defmodule XBudgetBackend.DomainsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `XBudgetBackend.Domains` context.
  """

  @doc """
  Generate a domain.
  """
  def domain_fixture(attrs \\ %{}) do
    {:ok, domain} =
      attrs
      |> Enum.into(%{
        title: "some title",
        percentage: 120.5
      })
      |> XBudgetBackend.Domains.create_domain()

    domain
  end
end
