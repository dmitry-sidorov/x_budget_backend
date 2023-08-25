defmodule XBudgetBackendWeb.DefaultController do
  use XBudgetBackendWeb, :controller

  def index(conn, _params) do
    text(conn, "X Bidget API is ALIVE! - #{Mix.env()}")
  end
end
