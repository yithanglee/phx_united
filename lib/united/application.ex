defmodule United.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      United.Repo,
      # Start the Telemetry supervisor
      UnitedWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: United.PubSub},
      # Start the Endpoint (http/https)
      UnitedWeb.Endpoint,
      United.Scheduler
      # Start a worker by calling: United.Worker.start_link(arg)
      # {United.Worker, arg}
    ]

    path = File.cwd!() <> "/media"

    if File.exists?(path) == false do
      File.mkdir(File.cwd!() <> "/media")
    end

    File.rm_rf("#{Application.app_dir(:united)}/priv/static/images/uploads")

    File.ln_s(
      "#{File.cwd!()}/media/",
      "#{Application.app_dir(:united)}/priv/static/images/uploads"
    )

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: United.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    UnitedWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
