use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :hello, HelloWeb.Endpoint,
  http: [port: 8001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :hello, Hello.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "jingjing_duan",
  password: "",
  database: "hello_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
