defmodule Splurty.Endpoint do
  use Phoenix.Endpoint, otp_app: :splurty

  plug Plug.Static,
    at: "/", from: :splurty

  plug Plug.Logger

  # Code reloading will only work if the :code_reloader key of
  # the :phoenix application is set to true in your config file.
  plug Phoenix.CodeReloader

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_splurty_key",
    signing_salt: "+2br6A4+",
    encryption_salt: "q4Xp9kny"

  plug :router, Splurty.Router
end
