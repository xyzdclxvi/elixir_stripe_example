defmodule SVWeb.ProductController do
  use SVWeb, :controller
  alias SV.Stripe

  def index(conn, _params) do
    {:ok, %{"data" => products}} = Stripe.list_products()
    render(conn, "index.html", products: products)
  end

  def show(conn, %{"id" => id}) do
    {:ok, product} = Stripe.get_product(id)
    {:ok, %{"data" => prices}} = Stripe.list_prices_for_product(product["id"])
    customer_id = Stripe.get_customer_id_by_email(conn.assigns[:user_email])
    {:ok, %{"data" => subscriptions}} = Stripe.get_subscriptions_for_customer(customer_id)
    subscribed_ids = Enum.map(subscriptions, & &1["plan"]["product"])
    render(conn, "show.html", product: product, prices: prices, subscribed_ids: subscribed_ids)
  end

  def create(conn, %{"p" => %{"price_id" => price_id, "mode" => mode, "shippable" => shippable}}) do
    base_url = Routes.product_url(conn, :index)
    customer_email = conn.assigns[:user_email]
    customer_id = Stripe.get_customer_id_by_email(customer_email)

    {:ok, %{"url" => url}} =
      SV.Stripe.create_session(base_url, price_id, mode, shippable, customer_email, customer_id)

    redirect(conn, external: url)
  end

  def success(conn, _params) do
    render(conn, "success.html")
  end
end
