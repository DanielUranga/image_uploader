defmodule ImageUploaderDemo.Demo.Consumer do
  use GenStage

  def start_link, do: start_link([])
  def start_link(opts), do: GenStage.start_link(__MODULE__, opts)

  def init(opts) do
    IO.puts(inspect(opts))
    subscribe_to = Keyword.get(opts, :subscribe_to, ImageUploaderDemo.Demo.Producer)

    {:consumer, :unused, subscribe_to: subscribe_to}
  end

  def handle_info(_, state), do: {:noreply, [], state}

  def handle_events(events, _from, state) when is_list(events) and length(events) > 0 do
    # events handling here

    events
    |> Enum.each(fn data ->
      ImageUploaderDemo.Demo.S3.upload(data)
    end)

    {:noreply, [], state}
  end

  def handle_events(_events, _from, state), do: {:noreply, [], state}
end
