defmodule BodhCloudWeb.DeviceChannel do
  use Phoenix.Channel

  def join("echo", _message, socket) do
    {:ok, socket}
  end

  def join("device:" <> _device_id, _params, socket) do
    {:ok, socket}
  end

  def handle_in("new_msg", payload, socket) do
    case socket.topic do
      "device:" <> device_id ->
        event_params = %{
          "device_id" => device_id,
          "data" => payload
        }

        with {:ok, %BodhCloud.Device.Event{}} <-
               BodhCloud.Device.create_event(event_params) do
          push(socket, "phx_reply", %{ok: true})
          {:noreply, socket}
        else
          error -> {:error, %{reason: error}}
        end

      "echo" ->
        push(socket, "phx_reply", payload)
        {:noreply, socket}

      _ ->
        {:noreply, socket}
    end
  end
end
