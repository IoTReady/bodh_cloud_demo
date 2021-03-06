defmodule BodhCloudWeb.EventView do
  use BodhCloudWeb, :view
  alias BodhCloudWeb.EventView

  def render("index.json", %{events: events}) do
    %{data: render_many(events, EventView, "event.json")}
  end

  def render("show.json", %{event: event}) do
    %{data: render_one(event, EventView, "event.json")}
  end

  def render("event.json", %{event: event}) do
    %{
      id: event.id,
      device_id: event.device_id,
      data: event.data
    }
  end
end
