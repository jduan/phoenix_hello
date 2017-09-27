defmodule HelloWeb.PageController do
  use HelloWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def show(conn, %{"id" => id}) do
    # 1. plain text
    # text conn, "Showing id #{id}"

    # 2. JSON response
    # json conn, %{id: id}

    # 3. HTML directly
    html conn, """
       <html>
         <head>
            <title>Passing an Id</title>
         </head>
         <body>
           <p>You sent in id #{id}</p>
         </body>
       </html>
      """
  end
end
