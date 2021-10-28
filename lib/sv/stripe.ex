defmodule SV.Stripe do
  @moduledoc """
  The Stripe context.
  """

  def list_products do
    Stripy.req(:get, "products", %{active: true})
    |> decode()
  end

  def get_product(id) do
    Stripy.req(:get, "products/#{id}")
    |> decode()
  end

  def create_product(%{} = attrs) do
    Stripy.req(:post, "products", attrs)
    |> decode()
  end

  def create_price(%{} = attrs) do
    Stripy.req(:post, "prices", attrs)
    |> decode()
  end

  def list_prices_for_product(product_id) do
    Stripy.req(:get, "prices", %{product: product_id, active: true})
    |> decode()
  end

  def create_session(base_url, price_id, mode, shippable, customer_email, customer_id) do
    attrs = %{
      cancel_url: "#{base_url}",
      success_url: "#{base_url}success",
      customer_email: customer_email,
      customer: customer_id,
      "payment_method_types[0]": "card",
      mode: mode,
      "line_items[0][price]": price_id,
      "line_items[0][quantity]": 1
    }

    # You can only specify either customer or customer_email, not both
    attrs =
      if customer_id, do: Map.delete(attrs, :customer_email), else: Map.delete(attrs, :customer)

    # Add shipping address inputs to the checkout if the product is shippable
    attrs =
      if shippable do
        Map.merge(attrs, %{"shipping_address_collection[allowed_countries][0]": "US"})
      else
        attrs
      end

    Stripy.req(:post, "checkout/sessions", attrs)
    |> decode
  end

  def get_customer_id_by_email(email) do
    Stripy.req(:get, "customers", %{email: email})
    |> decode()
    |> case do
      {:ok, %{"data" => [%{"id" => id} | _]}} -> id
      _ -> nil
    end
  end

  defp decode({:ok, %HTTPoison.Response{body: body}}), do: Poison.decode(body)
  defp decode(error), do: error
end
