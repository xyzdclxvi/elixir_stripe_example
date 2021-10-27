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
    |> decode
  end

  def create_price(%{} = attrs) do
    Stripy.req(:post, "prices", attrs)
    |> decode
  end

  def list_prices_for_product(product_id) do
    Stripy.req(:get, "prices", %{product: product_id, active: true})
    |> decode
  end

  defp decode({:ok, %HTTPoison.Response{body: body}}), do: Poison.decode(body)
  defp decode(error), do: error
end
