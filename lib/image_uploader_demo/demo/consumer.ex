defmodule ImageUploaderDemo.Demo.Consumer do
  use GenStage

  def start_link, do: start_link([])
  def start_link(opts), do: GenStage.start_link(__MODULE__, opts)

  def init(opts) do
    subscribe_to = Keyword.get(opts, :subscribe_to, ImageUploaderDemo.Demo.Producer)

    {:consumer, :unused, subscribe_to: subscribe_to}
  end

  def handle_info(_, state), do: {:noreply, [], state}

  def handle_events(events, _from, state) when is_list(events) and length(events) > 0 do
    s3_module = Application.get_env(:image_uploader_demo, :s3_module)

    events
    |> Enum.each(fn data ->
      s3_module.upload(data)
    end)

    {:noreply, [], state}
  end

  def handle_events(_events, _from, state), do: {:noreply, [], state}
end
