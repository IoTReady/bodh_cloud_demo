defmodule BodhCloud.DeviceFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BodhCloud.Device` context.
  """

  @doc """
  Generate a event.
  """
  def event_fixture(attrs \\ %{}) do
    {:ok, event} =
      attrs
      |> Enum.into(%{
        data: %{},
        device_id: "some device_id"
      })
      |> BodhCloud.Device.create_event()

    event
  end
end
