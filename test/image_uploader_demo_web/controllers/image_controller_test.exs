defmodule ImageUploaderDemoWeb.ImageControllerTest do
  import Mox
  use ImageUploaderDemoWeb.ConnCase
  alias ImageUploaderDemo.Demo

  setup :verify_on_exit!

  describe "create image" do
    test "returns 'created' on image upload", %{conn: conn} do
      ImageUploaderDemo.Demo.ProducerMock
      |> expect(:add, fn (_image_data, module) ->
        assert(module == Application.get_env(:image_uploader_demo, :producer))
      end)

      upload = %Plug.Upload{path: "test/data/test.jpg", filename: "test.jpg"}
      conn = conn |> post("/api/upload", %{:image => upload})
      assert json_response(conn, 201)
    end
  end
end
