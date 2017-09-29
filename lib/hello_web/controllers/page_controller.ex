defmodule HelloWeb.PageController do
  use HelloWeb, :controller

  plug :assign_welcome_message, "Welcome Back" when action in [:index, :show]

  def index(conn, _params) do
    # assign conveniently returns "conn"
    conn
    # |> assign(:message, "Welcome Back!")
    |> assign(:name, "Dweezil")
    # both :message and :name will be available in the template
    # |> put_layout("admin.html")
    |> render("index.html")
    # |> render("index.text", message: message)
  end

  def help(conn, _params) do
    # redirect conn, to: "/redirect_test"
    redirect conn, to: redirect_test_path(conn, :redirect_test)
    # redirect conn, external: "https://elixir-lang.org/"
  end

  def redirect_test(conn, _params) do
    text conn, "Redirect!"
  end

  def show(conn, %{"id" => id}) do
    IO.inspect conn

    # 1. plain text
    # text conn, "Showing id #{id}"

    # 2. JSON response
    # json conn, %{id: id}

    # 3. HTML directly
    # html conn, """
    #    <html>
    #      <head>
    #         <title>Passing an Id</title>
    #      </head>
    #      <body>
    #        <p>You sent in id #{id}</p>
    #      </body>
    #    </html>
    #   """

    # 4. send responses directly by calling Plug functions
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(201, "")
  end

  def index2(conn, _params) do
    pages = [%{title: "foo"}, %{title: "bar"}]

    render conn, "index.json", pages: pages
  end

  def show2(conn, _params) do
    page = %{title: "foo"}

    render conn, "show.json", page: page
  end

  def test(conn, _params) do
    render conn, "test.html"
  end

  # assign a default message
  defp assign_welcome_message(conn, msg) do
    assign(conn, :message, msg)
  end
end
