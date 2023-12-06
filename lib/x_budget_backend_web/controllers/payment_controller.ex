defmodule XBudgetBackendWeb.PaymentController do
  use XBudgetBackendWeb, :controller

  alias XBudgetBackend.Payments
  alias XBudgetBackend.Payments.Payment

  action_fallback XBudgetBackendWeb.FallbackController

  def index(conn, _params) do
    payments = Payments.list_payments()
    render(conn, :index, payments: payments)
  end

  def create(conn, %{"payment" => payment_params}) do
    with {:ok, %Payment{} = payment} <- Payments.create_payment(payment_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/payments/#{payment}")
      |> render(:show, payment: payment)
    end
  end

  def show(conn, %{"id" => id}) do
    payment = Payments.get_payment!(id)
    render(conn, :show, payment: payment)
  end

  def update(conn, %{"id" => id, "payment" => payment_params}) do
    payment = Payments.get_payment!(id)

    with {:ok, %Payment{} = payment} <- Payments.update_payment(payment, payment_params) do
      render(conn, :show, payment: payment)
    end
  end

  def delete(conn, %{"id" => id}) do
    payment = Payments.get_payment!(id)

    with {:ok, %Payment{}} <- Payments.delete_payment(payment) do
      send_resp(conn, :no_content, "")
    end
  end
end