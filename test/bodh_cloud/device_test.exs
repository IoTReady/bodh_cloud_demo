defmodule BodhCloud.DeviceTest do
  use BodhCloud.DataCase

  alias BodhCloud.Device

  describe "events" do
    alias BodhCloud.Device.Event

    import BodhCloud.DeviceFixtures

    @invalid_attrs %{data: nil, device_id: nil}

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Device.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Device.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      valid_attrs = %{data: %{}, device_id: "some device_id"}

      assert {:ok, %Event{} = event} = Device.create_event(valid_attrs)
      assert event.data == %{}
      assert event.device_id == "some device_id"
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Device.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      update_attrs = %{data: %{}, device_id: "some updated device_id"}

      assert {:ok, %Event{} = event} = Device.update_event(event, update_attrs)
      assert event.data == %{}
      assert event.device_id == "some updated device_id"
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Device.update_event(event, @invalid_attrs)
      assert event == Device.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Device.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Device.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Device.change_event(event)
    end
  end
end
