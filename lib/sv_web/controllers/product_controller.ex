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
    render(conn, "show.html", product: product, prices: prices)
  end
end
