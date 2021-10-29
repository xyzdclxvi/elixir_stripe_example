defmodule SV.Plugs.RequireUser do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    case get_session(conn, :user_email) do
      nil ->
        random_email =
          "#{:crypto.strong_rand_bytes(10) |> Base.url_encode64() |> binary_part(0, 10)}@example.com"

        conn
        |> put_session(:user_email, random_email)
        |> assign(:user_email, random_email)

      user_email ->
        conn
        |> assign(:user_email, user_email)
    end
  end
end
