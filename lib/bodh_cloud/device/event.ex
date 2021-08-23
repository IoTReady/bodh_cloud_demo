defmodule BodhCloud.Device.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :data, :map
    field :device_id, :string

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:device_id, :data])
    |> validate_required([:device_id, :data])
  end
end
