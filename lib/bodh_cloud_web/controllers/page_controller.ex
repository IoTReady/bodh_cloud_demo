defmodule BodhCloudWeb.PageController do
  use BodhCloudWeb, :controller

  alias BodhCloud.Device

  def index(conn, _params) do
    events =
      Device.list_events()
      |> Enum.map(fn e -> Map.put(e.data, "device_id", e.device_id) end)
      |> Enum.filter(fn e -> Map.has_key?(e, "time_for_prime") end)

    conn = assign(conn, :data, events)
    render(conn, "index.html")
  end
end
