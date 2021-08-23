defmodule BodhCloud.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :device_id, :string
      add :data, :map

      timestamps()
    end
  end
end
