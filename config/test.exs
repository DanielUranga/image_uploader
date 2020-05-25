use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :image_uploader_demo, ImageUploaderDemoWeb.Endpoint,
  http: [port: 4002],
  server: false

config :image_uploader_demo,
  producer: ImageUploaderDemo.Demo.ProducerMock,
  s3_module: ImageUploaderDemo.Demo.S3Mock

# Print only warnings and errors during test
config :logger, level: :warn
