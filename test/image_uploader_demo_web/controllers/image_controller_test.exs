defmodule ImageUploaderDemoWeb.ImageControllerTest do
  use ImageUploaderDemoWeb.ConnCase

  alias ImageUploaderDemo.Demo

  describe "create image" do
    test "can upload an image", %{conn: conn} do
      upload = %Plug.Upload{path: "test/data/test.jpg", filename: "test.jpg"}
      conn = conn |> post("/api/upload", %{ :image => upload })
      assert json_response(conn, 201)
    end
  end

end
