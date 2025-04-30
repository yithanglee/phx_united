# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
use Mix.Config

database_url =
  System.get_env("DATABASE_URL") ||
    raise """
    environment variable DATABASE_URL is missing.
    For example: ecto://USER:PASS@HOST/DATABASE
    """

config :united, United.Repo,
  # ssl: true,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

config :united, UnitedWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000"),
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: secret_key_base

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
config :united, UnitedWeb.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.

config :united, :facebook,
  accounting_url: System.get_env("ACCOUNTING_URL_PROD"),
  base_url: System.get_env("FB_CALLBACK_PROD") |> String.split("/fb_callback") |> List.first(),
  callback_url: System.get_env("FB_CALLBACK_PROD")

config :united, FbEcom.Mailer, adapter: Bamboo.SendGridAdapter

# config :united, United.Mailer,
#   adapter: Bamboo.SendGridAdapter,
#   api_key: System.get_env("SENDGRID_KEY"),
#   hackney_opts: [
#     recv_timeout: :timer.minutes(1)
#   ]

# config :united, United.Mailer,
#   adapter: Bamboo.SMTPAdapter,
#   server: "139.162.60.209",
#   hostname: "damienslab.com",
#   port: 25,
#   username: "ubuntu",
#   password: "unwanted2",
#   tls: :never,
#   allowed_tls_versions: [:tlsv1, :"tlsv1.1", :"tlsv1.2"],
#   tls_log_level: :error,
#   tls_verify: :verify_none,
#   ssl: false,
#   retries: 1,
#   no_mx_lookups: false,
#   auth: :if_available

config :united, United.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: "smtp.mailersend.net",
  hostname: "united_app",
  port: 587,
  username: System.get_env("MS_USERNAME"),
  password: System.get_env("MS_PW"),
  tls: :always,
  allowed_tls_versions: [:"tlsv1.2"],
  tls_log_level: :error,
  tls_verify: :verify_none,
  ssl: false,
  retries: 1,
  no_mx_lookups: false,
  auth: :if_available

config :united, :firebase,
  apiKey: System.get_env("G_API_KEY"),
  authDomain: System.get_env("FIREBASE_AUTH_DOMAIN"),
  projectId: System.get_env("FIREBASE_PROJECT_ID"),
  storageBucket: System.get_env("FIREBASE_BUCKET"),
  messagingSenderId: System.get_env("FIREBASE_MSID"),
  appId: System.get_env("FIREBASE_APPID")
