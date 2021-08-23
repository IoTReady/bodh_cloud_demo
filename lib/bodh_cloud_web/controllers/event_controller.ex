defmodule BodhCloudWeb.EventController do
  use BodhCloudWeb, :controller

  alias BodhCloud.Device
  alias BodhCloud.Device.Event

  action_fallback BodhCloudWeb.FallbackController

  def index(conn, _params) do
    events = Device.list_events()
    render(conn, "index.json", events: events)
  end

  def create(conn, %{"event" => event_params}) do
    with {:ok, %Event{} = event} <- Device.create_event(event_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.event_path(conn, :show, event))
      |> render("show.json", event: event)
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
end
