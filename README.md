# Simple Vendor app example with Stripe and Elixir/Phoenix

You'll need Stripe API keys to run this app.

Register for a **free sandbox** account on Stripe (takes about 10 seconds): https://dashboard.stripe.com/register

This is just an example app, don't use it with production API keys.

---

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Set environment variables using your Stripe sandbox API keys:
  ```
  export STRIPE_SECRET_KEY=sk_test_51Jke...
  export STRIPE_PUBLIC_KEY=pk_test_51Jke...
  ```
  * Seed products and prices to Stripe: `mix run priv/seeds.exs`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
