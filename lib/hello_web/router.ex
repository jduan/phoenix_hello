defmodule HelloWeb.Router do
  use HelloWeb, :router
  # import HelloWeb.Router.Helpers

  pipeline :browser do
    plug :accepts, ["html", "text"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HelloWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/test", PageController, :test

    get "/index2", PageController, :index2
    get "/help", PageController, :help
    get "/show2", PageController, :show2
    get "/show/:id", PageController, :show
    # get "/hello", HelloController, :index
    # get "/hello/:messenger", HelloController, :show
    resources "/users", UserController
    resources "/sessions", SessionController, only: [:new, :create, :delete],
      # define RESTful routes but doesn't require a resource ID to be
      # passed along in the URL becuase our actions are always scoped to
      # the "current" user in the system
      singleton: true
  end

  scope "/cms", HelloWeb.CMS, as: :cms do
    pipe_through [:browser, :authenticate_user]

    resources "/pages", PageController
  end

  scope "/", HelloWeb do
    get "/redirect_test", PageController, :redirect_test, as: :redirect_test
  end

  scope "/admin", HelloWeb.Admin, as: :admin do
    pipe_through :browser
    resources "/reviews", ReviewController
  end

  # Other scopes may use custom stacks.
  # scope "/api", HelloWeb do
  #   pipe_through :api
  # end

  defp authenticate_user(conn, _) do
    case get_session(conn, :user_id) do
      nil ->
        conn
        |> Phoenix.Controller.put_flash(:error, "Login required")
        |> Phoenix.Controller.redirect(to: "/sessions/new")
        |> halt()
      user_id ->
        assign(conn, :current_user, Hello.Accounts.get_user!(user_id))
    end
  end
end
