defmodule ImageUploaderDemoWeb.ImageControllerTest do
  import Mox
  use ImageUploaderDemoWeb.ConnCase
  alias ImageUploaderDemo.Demo

  setup :verify_on_exit!

  describe "create image" do
    test "returns 'created' on image upload", %{conn: conn} do
      ImageUploaderDemo.Demo.ProducerMock
      |> expect(:add, fn (module, _image_data) ->
        assert(module == Application.get_env(:image_uploader_demo, :producer_name))
      end)

      upload = %Plug.Upload{path: "test/data/test.jpg", filename: "test.jpg"}
      conn = conn |> post("/api/upload", %{:image => upload})
      assert json_response(conn, 201)
    end
  end
end
