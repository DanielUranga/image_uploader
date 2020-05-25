defmodule ImageUploaderDemo.Demo.ConsumerTest do
  import Mox
  use ExUnit.Case
  alias ImageUploaderDemo.Demo.Consumer
  alias ImageUploaderDemo.Demo.Producer

  setup :verify_on_exit!

  test "uploads image to s3 when receiving a message" do
    test_data = "something"
    parent = self()
    ref = make_ref()

    ImageUploaderDemo.Demo.S3Mock
    |> expect(:upload, fn data ->
      assert(test_data == data)
      send(parent, {:upload, ref})
    end)

    {:ok, producer_pid} = Producer.start_link(name: :test_upload_to_s3)
    {:ok, consumer_pid} = Consumer.start_link(subscribe_to: [{:test_upload_to_s3, []}])
    ImageUploaderDemo.Demo.S3Mock |> allow(parent, consumer_pid)
    Producer.add(:test_upload_to_s3, test_data)

    assert_receive({:upload, ^ref}, 100)

    GenStage.stop(producer_pid)
  end

  test "receives and processes a thousand messages" do
    sent = for n <- 1..1_000, do: n
    parent = self()
    ref = make_ref()

    ImageUploaderDemo.Demo.S3Mock
    |> expect(:upload, length(sent), fn data ->
      if data == length(sent) do
        send(parent, {:upload, ref})
      end
    end)

    {:ok, producer_pid} = Producer.start_link(name: :test_upload_fifo)
    {:ok, consumer_pid} = Consumer.start_link(subscribe_to: [{:test_upload_fifo, []}])
    ImageUploaderDemo.Demo.S3Mock |> allow(parent, consumer_pid)

    sent |> Enum.each(&(Producer.add(:test_upload_fifo, &1)))

    assert_receive({:upload, ^ref}, 1000)

    GenStage.stop(producer_pid)
  end
end
