defmodule ImageUploaderDemo.Demo.ProducerTest do
  use ExUnit.Case
  alias ImageUploaderDemo.Demo.Producer

  test "add/2 produces a message" do
    {:ok, pid} = Producer.start_link(name: :test_add)
    {:ok, _cons} = TestConsumer.start_link(pid)

    random_data = Enum.random(0..10_000)
    Producer.add(:test_add, random_data)
    assert_receive({:received, [random_data]})

    GenStage.stop(pid)
  end
end

defmodule TestConsumer do
  def start_link(producer) do
    GenStage.start_link(__MODULE__, {producer, self()})
  end

  def init({producer, owner}) do
    {:consumer, owner, subscribe_to: [producer]}
  end

  def handle_events(events, _from, owner) do
    send(owner, {:received, events})
    {:noreply, [], owner}
  end
end
