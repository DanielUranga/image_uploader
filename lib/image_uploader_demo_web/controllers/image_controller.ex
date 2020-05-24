defmodule ImageUploaderDemoWeb.ImageController do
  use ImageUploaderDemoWeb, :controller

  def create(conn, %{"image" => image_params}) do
    IO.inspect(image_params)

    conn
    |> put_status(:created)
    |> json("OK")
  end
end
