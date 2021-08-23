defmodule BodhCloudWeb.EventController do
  use BodhCloudWeb, :controller
  use Filterable.Phoenix.Controller

  import Ecto.Query

  alias BodhCloud.{Device, Repo}
  alias BodhCloud.Device.Event

  action_fallback BodhCloudWeb.FallbackController

  filterable do
    filter device_id(query, value, _conn) do
      query |> where(device_id: ^value)
    end

    @options cast: :datetime, cast_errors: false
    filter inserted_at(query, value, _conn) do
      query |> where([q], q.inserted_at >= ^value)
    end

    limitable(limit: 1_000_000)
    orderable([:device_id, :inserted_at])
  end

  def index(conn, _params) do
    with {:ok, query, filter_values} <- apply_filters(Event, conn),
         events <- Repo.all(query),
         do: render(conn, "index.json", events: events, meta: filter_values)
  end

  def create(conn, %{"event" => event_params}) do
    with {:ok, %Event{} = _event} <- Device.create_event(event_params) do
      conn
      |> Plug.Conn.send_resp(:ok, "")
    end
  end

  def show(conn, %{"id" => id}) do
    event = Device.get_event!(id)
    render(conn, "show.json", event: event)
  end

  def update(conn, %{"id" => id, "event" => event_params}) do
    event = Device.get_event!(id)

    with {:ok, %Event{} = event} <- Device.update_event(event, event_params) do
      render(conn, "show.json", event: event)
    end
  end

  def delete(conn, %{"id" => id}) do
    event = Device.get_event!(id)

    with {:ok, %Event{}} <- Device.delete_event(event) do
      send_resp(conn, :no_content, "")
    end
  end

  def healthcheck(conn, _) do
    conn |> json(%{ok: true, server_time: DateTime.utc_now()}) |> halt()
  end
end
