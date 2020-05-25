# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :image_uploader_demo, ImageUploaderDemoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "kqSE/zMdtPwsAk/3bXY58Khu+e/qC1StHUSAfv0J0r0jcf8tHV/l6keHGBxrpnJt",
  render_errors: [view: ImageUploaderDemoWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ImageUploaderDemo.PubSub,
  live_view: [signing_salt: "xjhZY5ax"]

config :image_uploader_demo, :producer_name, Producer

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
