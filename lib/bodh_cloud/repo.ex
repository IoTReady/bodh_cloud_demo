defmodule BodhCloud.Repo do
  use Ecto.Repo,
    otp_app: :bodh_cloud,
    adapter: Ecto.Adapters.Postgres
end
