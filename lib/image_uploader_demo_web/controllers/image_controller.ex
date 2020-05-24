defmodule ImageUploaderDemoWeb.ImageController do
  use ImageUploaderDemoWeb, :controller

  def create(conn, %{"image" => image_params}) do
    # Read and send bytes to producer, since once the query finishes Phoenix will delete the uploaded file
    image_bytes = image_params.path |> File.read!()

    producer_module =
      Application.get_env(:image_uploader_demo, :producer, ImageUploaderDemo.Demo.Producer)

    producer_module.add(image_bytes, producer_module)

    conn
    |> put_status(:created)
    |> json("OK")
  end
end
