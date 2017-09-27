defmodule HelloWeb.PageController do
  use HelloWeb, :controller

  plug :assign_welcome_message, "Welcome Back" when action in [:index, :show]

  def index(conn, _params) do
    # assign conveniently returns "conn"
    conn
    |> assign(:message, "Welcome Back!")
    |> assign(:name, "Dweezil")
    # both :message and :name will be available in the template
    |> put_layout("admin.html")
    |> render("index.html")
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

  # assign a default message
  defp assign_welcome_message(conn, msg) do
    assign(conn, :message, msg)
  end
end
