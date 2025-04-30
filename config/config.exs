# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :united,
  ecto_repos: [United.Repo]

# Configures the endpoint
config :united, UnitedWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "IdcF5HXBHZs3Vi9wXjCqqBYOJFTha3/nNYlRgtNMTtsWVZT69I/26G90KnUAqh05",
  render_errors: [view: UnitedWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: United.PubSub,
  live_view: [signing_salt: "OuHuDKgj"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :blue_potion,
  otp_app: "United",
  repo: United.Repo,
  contexts: ["Settings"],
  project: %{
    name: "United",
    alias_name: "#{System.get_env("ALIAS_NAME")}",
    sname: "#{System.get_env("SNAME")}",
    vsn: "0.1.0"
  },
  server: %{
    url: "139.162.60.209",
    db_url: "127.0.0.1",
    username: "ubuntu",
    key: System.get_env("SERVER_KEY"),
    domain_name: "localhost"
  }

config :timex, Timex.Gettext, default_locale: "en"

config :united, :facebook,
  app_token: System.get_env("APP_TOKEN"),
  app_secret: System.get_env("APP_SECRET"),
  app_id: System.get_env("APP_ID")

config :united, :firebase, api_key: System.get_env("G_API_KEY")

config :united, United.Scheduler,
  jobs: [
    {"55 0 * * 7", {United, :loan_reminder, ["1"]}},
    {"55 0 * * 3", {United, :loan_reminder, ["1"]}},
    {"55 0 * * 1", {United, :loan_reminder, ["1"]}}
  ]

config :joken,
  rs256: [
    signer_alg: "RS256",
    key_pem: """
    -----BEGIN PRIVATE KEY-----
    MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDBzi1rnk3SdUsy
    VsFUPrWsecb1NYC0ywykZ6O/O+CZGJ5/T4xyyJXlenzXfRLteQWN1SOd3w/RlUV+
    H6cN9jMM2BngWbBXDJm1jiWhExyvL67Nvh0+NN3ODzYx+7nVmICRI1NeXpLe4zV8
    RGyUS6b+96197ddjV7sPX+bNhN2rVsPGNAfra6kM2XwCau1ggyS+s/3diZ6x1GJT
    eM9Fv5oSXgKerGRCwe5MTRqtOGk4XIiuIHS3K2biTKCk/fGiU6uc/Re4e/mXUDtH
    DLMIuYD9sHa24lNBWi1Ow1Vpdlk4h/oWBL38J3xSzrMHRc0o7YwQTAJpX68eP6v+
    7wOnsTxbAgMBAAECggEAFh5JOcCJ4iyHxfl3u/0iL8qAJekSxM9tpG+9lOwpAF/6
    as4x2cHBtbxqdg9ssxR+SUcbdv+HpyQxl6jWIHZKMjuRjHS/9tdVzY4pBj6PpgC7
    oviBDuHqtIMw7LhtZ46tkaLl9120xmJI7uNCPxR5PR0YPEiCLfDLxP/tb+QrhkvA
    I9soofcQiHRK7C8au9bsPza6qLfryQPPDEi8WG3FTLLZfxMGf8DKDRn5UmDf9Yaz
    Cic0uViwqZM4auK/39CL2jDXoJMoPeBuol3sVn4Xe0waKb75xzf01+/XUMfkeJKF
    DJ7BhK+7Xy0ITbe0Qs0lrozWyOmyyzHWLE+pPTCc4QKBgQDz59N9V8x3icXsACI2
    y5iuqACKzt/zhqQLQ4L0KuAWPIpMYfD1lOFXjLWD3NmGQVhv3YhGZa48W3LmrRkd
    YBDpZpPyW0HYA/KbHIzZyhujXOPX3N+59mAPStAi8dNCh3NSyT5f0RvwoWw4UFh+
    nqNT2bvL7VW+MdxPNqlWgEqCewKBgQDLal85VbuecD2QKer39PxBnTsGyEW+PDsI
    qZhcVw6e12EUT/vpzQfwelms4NO5wlXc2rea/KS3CUJKMmHD9vJ9qkMXhbDNUzOT
    2ekFVOr609Qm23onCXENtcCZ5ZV1LR6GGFQupWXMy6yZL18CXjnXtCQc5Cy5xTpl
    ukMOaip3oQKBgCNqSf8tPHcu/hoietVSAr15j3qYR1Ro/HDWQLGLeDZCXCJzJjXC
    hGXd/I1FCCDCZED5/cubAA2riaeNAtSNGmeJiXnrXkgrapKzNpB5FEJIPp0daS7r
    Y09VIZuxWWeTm18t8WygRFpQVhJnODJKfpSyTN5ze7u+Kasm2LfCsQ75AoGBAKoO
    Op+PKfPx97W/JX24JO+hx8gKxCue5OeACS0hZsqqWrGFkJ/MVdfYIYIizz6b1fZ2
    L0r17apLpkyrRAp1OBKQtdhDXyS4awUvBtz7OhsJ3nHByKQ8A3SnvuWqBsHYP41x
    Z2c7xRhqKdhCvxYWuhq3sf0pUK7Z0NFc31R8sxYhAoGAdcpbvbFbZI1kffpvaRAF
    v5WazadPVynTeDrkwCb+XZUk484mB0na2woyTkvg1IMk0sIF0w5Gf+ANmMq/d0lm
    SUO2vAYE+OxL8cPpN0sBfcfIJAJZSKYyhgwKvmqkD2zoPlE7J/gBeuM84SK4LzTP
    TGf1XjP/ptCPlSQg+WeBwk8=
    -----END PRIVATE KEY-----
    """
  ]
