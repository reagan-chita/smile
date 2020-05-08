defmodule SmileWeb.PageController do
  use SmileWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
