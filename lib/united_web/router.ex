defmodule UnitedWeb.Router do
  use UnitedWeb, :router

  if Mix.env() == :dev do
    # If using Phoenix
    forward "/sent_emails", Bamboo.SentEmailViewerPlug
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :svt_api do
    plug :accepts, ["json"]

    plug CORSPlug,
      headers: [
        "Content-Type",
        "Authorization",
        "phx-request"
      ],
      methods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"],
      origin: [
        "https://b4ae-115-164-179-236.ngrok-free.app",
        "http://b4ae-115-164-179-236.ngrok-free.app",
        "https://fonts.gstatic.com",
        "https://library.pioneercommunity.org.my",
        "http://library.pioneercommunity.org.my",
        "https://pioneer.damienslab.com",
        "http://pioneer.damienslab.com",
        "http://localhost:5173",
        "http://localhost:3000",
        "http://localhost:3001"
      ]

    plug(United.ApiAuthorization)
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug(United.ApiAuthorization)
  end

  pipeline :blank do
    plug(:put_layout, {UnitedWeb.LayoutView, :blank})
    # plug(Materialize.Authorization)
  end

  pipeline :frontend do
    plug(:put_layout, {UnitedWeb.LayoutView, :frontend})
    # plug(Materialize.Authorization)
  end

  scope "/member", UnitedWeb do
    pipe_through :browser
    get("/dashboard", PageController, :member_dashboard)
    get("/login", LoginController, :index)
    get("/reset", LoginController, :reset)
    post("/reset", LoginController, :set_new_member_password)
    post("/authenticate", LoginController, :authenticate)
    get("/logout", LoginController, :logout)
  end

  scope "/admin", UnitedWeb do
    pipe_through :browser

    get("/dashboard", PageController, :dashboard)
    get("/login", LoginController, :index)
    get("/register", LoginController, :register)
    post("/register", LoginController, :create)
    post("/authenticate", LoginController, :authenticate)
    get("/logout", LoginController, :logout)
    get("/csv", PageController, :export_csv)
    get("/reset", LoginController, :admin_reset)
    post("/reset", LoginController, :set_admin_password)
    get("/*path", PageController, :dashboard)
  end

  scope "/api", UnitedWeb do
    pipe_through :api

    get("/webhook", ApiController, :webhook)
    post("/webhook", ApiController, :webhook_post)
    delete("/webhook", ApiController, :webhook_delete)
    options("/:model", ApiController, :datatable)
    get("/:model", ApiController, :datatable)
    post("/:model", ApiController, :form_submission)
    delete("/:model/:id", ApiController, :delete_data)
  end

  scope "/svt_api", UnitedWeb do
    pipe_through :svt_api

    get("/webhook", ApiController, :webhook)
    post("/webhook", ApiController, :webhook_post)
    delete("/webhook", ApiController, :webhook_delete)
    options("/:model", ApiController, :datatable)
    get("/:model", ApiController, :datatable)
    post("/:model", ApiController, :form_submission)
    options("/:model/:id", ApiController, :delete_data)
    delete("/:model/:id", ApiController, :delete_data)
  end

  # Other scopes may use custom stacks.
  # scope "/api", UnitedWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: UnitedWeb.Telemetry
    end
  end

  scope "/", UnitedWeb do
    pipe_through [:browser, :blank]
    get "/show_page", PageController, :show_page
  end

  scope "/", UnitedWeb do
    pipe_through [:browser, :frontend]
    get "/book/:id", PageController, :show_book
    get "/events/:id", PageController, :show_event
    get "/*path", PageController, :index
  end
end
