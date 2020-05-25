defmodule ImageUploaderDemo.Demo.S3Behaviour do
  @callback upload(any) :: :ok
end

defmodule ImageUploaderDemo.Demo.S3 do
  @behaviour ImageUploaderDemo.Demo.S3Behaviour
  def upload(data) do
    IO.puts("Started image upload " <> inspect(data))
    Process.sleep(3000)
    IO.puts("Finished image upload")
  end
end
