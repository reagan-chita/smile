defmodule SmileWeb.SessionController do
  use SmileWeb, :controller
  alias Smile.Accounts.User
  import Plug.Conn

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => session_params}) do
    case Accounts.get_user_by_credentials(session_params) do
      :error ->
        conn
        |> put_flash(:error, "Invalid username/password combination")
        |> render("new.html")

      customer ->
        conn
        |> assign(:current_user, User)
        |> put_session(:user_id, User.id())
        |> configure_session(renew: true)
        |> put_flash(:info, "Login successful")
        |> redirect(to: Routes.user_path(conn, :index))
    end
  end
  def current_user(conn) do
    id = plug.conn.get_session(conn, :current_user)
    if(id, do: Smile.Repo.get(user, id)
end

  def login?(conn), do: !!current_user(conn)

  def delete(conn, _) do
    clear_session(conn)
    |> put_flash(:info, "You have been logged out")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
