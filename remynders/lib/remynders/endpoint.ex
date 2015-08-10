defmodule Remynders.Endpoint do
  use Phoenix.Endpoint, otp_app: :remynders

  plug Plug.Static,
    at: "/", from: :remynders

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
    key: "_remynders_key",
    signing_salt: "HMIwzkvD",
    encryption_salt: "ie3d27Ci"

  plug :router, Remynders.Router
end
