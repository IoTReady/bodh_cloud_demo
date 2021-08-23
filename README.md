# Bodh Cloud Demo With Fly.io

## Flow

**This is an insecure implementation - secured using X509 certificates or other means.**

- Device opens connection to `wss://<app-name>.fly.io/socket/websocket`
- Device connects to channel with `{"event": "phx_join", "topic": "device:<device_id>", "ref": 0, "payload": {}}`
- Device sends data with `{"event": "new_msg", "topic": "device:<device_id>", "ref": null, "payload": {"metric": "value"}}`
- `{"metric": "value"}` is stored in the events table alongwith `device_id`.


## Run locally

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Fly.io Tutorial: https://fly.io/docs/getting-started/elixir/
  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
