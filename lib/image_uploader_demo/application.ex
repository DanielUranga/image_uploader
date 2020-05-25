defmodule ImageUploaderDemo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    producer_name = Application.get_env(:image_uploader_demo, :producer_name)

    children = [
      # Start the Telemetry supervisor
      ImageUploaderDemoWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ImageUploaderDemo.PubSub},
      # Start the Endpoint (http/https)
      ImageUploaderDemoWeb.Endpoint,
      # Start a worker by calling: ImageUploaderDemo.Worker.start_link(arg)
      # {ImageUploaderDemo.Worker, arg},
      {ImageUploaderDemo.Demo.Producer, name: producer_name},
      {ImageUploaderDemo.Demo.Consumer, subscribe_to: [{producer_name, []}]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ImageUploaderDemo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ImageUploaderDemoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
