defmodule ImageUploaderDemo.Demo.S3 do
  def upload(data) do
    IO.puts("Started image upload " <> inspect(data))
    Process.sleep(3000)
    IO.puts("Finished image upload")
  end
end
