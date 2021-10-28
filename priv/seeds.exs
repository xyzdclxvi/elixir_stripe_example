# Products

SV.Stripe.create_product(%{
  id: "product_landfill",
  name: "Landfill 1 tonne",
  description: "1 tonne of dirt",
  shippable: true
})

SV.Stripe.create_product(%{
  id: "product_laundromat",
  name: "Laundromat access",
  description: "A code allowing one time or a recurring subscription access to the laundromat",
  shippable: false
})

SV.Stripe.create_product(%{
  name: "²³⁵U",
  active: false
})

SV.Stripe.create_product(%{
  id: "product_subscription_1",
  name: "Basic access subscription",
  description: "Access to super interesting web stuff",
  shippable: false
})

SV.Stripe.create_product(%{
  id: "product_subscription_2",
  name: "Premium access subscription",
  description: "Super access to mega interesting web stuff",
  shippable: false
})

# Prices

SV.Stripe.create_price(%{
  product: "product_landfill",
  currency: "EUR",
  unit_amount: 10000
})

SV.Stripe.create_price(%{
  product: "product_laundromat",
  currency: "EUR",
  unit_amount: 500
})

SV.Stripe.create_price(%{
  product: "product_laundromat",
  currency: "EUR",
  unit_amount: 1500,
  "recurring[interval]": "month"
})

SV.Stripe.create_price(%{
  product: "product_laundromat",
  currency: "EUR",
  unit_amount: 12000,
  "recurring[interval]": "year"
})

SV.Stripe.create_price(%{
  product: "product_subscription_1",
  currency: "EUR",
  unit_amount: 1000,
  "recurring[interval]": "month"
})

SV.Stripe.create_price(%{
  product: "product_subscription_2",
  currency: "EUR",
  unit_amount: 2000,
  "recurring[interval]": "month"
})
