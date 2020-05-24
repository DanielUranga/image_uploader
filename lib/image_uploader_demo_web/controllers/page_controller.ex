defmodule ImageUploaderDemoWeb.PageController do
  use ImageUploaderDemoWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
