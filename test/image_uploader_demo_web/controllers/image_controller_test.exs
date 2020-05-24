defmodule ImageUploaderDemoWeb.ImageControllerTest do
  use ImageUploaderDemoWeb.ConnCase

  alias ImageUploaderDemo.Demo

  describe "create image" do
    test "returns 'created' on image upload", %{conn: conn} do
      upload = %Plug.Upload{path: "test/data/test.jpg", filename: "test.jpg"}
      conn = conn |> post("/api/upload", %{:image => upload})
      assert json_response(conn, 201)
    end

    test "calls ImageUploaderDemo.Demo.Producer.add/1", %{conn: conn} do
    end
  end
end
