defmodule ImageUploaderDemo.Demo.ProducerBehaviour do
  @callback add(atom | pid | {atom, any} | {:via, atom, any}, any) :: :ok
end

defmodule ImageUploaderDemo.Demo.Producer do
  @behaviour ImageUploaderDemo.Demo.ProducerBehaviour
  use GenStage

  def start_link(opts) do
    {[name: name], opts} = Keyword.split(opts, [:name])
    GenStage.start_link(__MODULE__, opts, name: name)
  end

  def init(_opts) do
    {:producer, :unused, buffer_size: 1}
  end

  # public endpoint for events adding
  def add(name, events), do: GenStage.cast(name, {:add, events})

  def handle_cast({:add, event}, state), do: {:noreply, [event], state}

  # ignore any demand
  def handle_demand(_, state), do: {:noreply, [], state}
end
