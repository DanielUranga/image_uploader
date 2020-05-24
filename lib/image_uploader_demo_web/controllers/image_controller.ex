defmodule ImageUploaderDemoWeb.ImageController do
  use ImageUploaderDemoWeb, :controller

  def create(conn, %{"image" => image_params}) do
    # Read and send bytes to producer, since once the query finishes Phoenix will delete the uploaded file
    image_bytes = image_params.path |> File.read!()
    ImageUploaderDemo.Demo.Producer.add(image_bytes)

    conn
    |> put_status(:created)
    |> json("OK")
  end
end
