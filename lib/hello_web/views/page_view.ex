defmodule HelloWeb.PageView do
  use HelloWeb, :view

  # def render("index.html", assigns) do
  #   "rendering with assigns #{inspect Map.keys(assigns)}"
  # end

  def message do
    "Hello from the view!"
  end
end
