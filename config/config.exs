# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :scratch,
  ecto_repos: [Scratch.Repo]

# Configures the endpoint
config :scratch, ScratchWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "V2uHQCoViVW9kOvVdG5NmGuGxK4vsvJnlN2XLfe83KUjeOKBt1hSfnQt4CJE/XXX",
  render_errors: [view: ScratchWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Scratch.PubSub,
  live_view: [signing_salt: "XOz3yGKu"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason


config :scratch, Scratch.Guardian,
       issuer: "scratch",
       secret_key: "sfI/s0TKVuSDl8ziwCsz+Y58sRo4tNklv4OFCduIIo03ROZJht+nrlDecl4OCN2o"

config :waffle, storage: Waffle.Storage.Local

config :cors_plug,
  origin: "*",
  max_age: 86400,
  methods: ["GET", "POST"]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
