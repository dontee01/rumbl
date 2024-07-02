defmodule RumblWeb.UserController do
  use RumblWeb, :controller

  alias Rumbl.Accounts
  alias Rumbl.Accounts.User

  plug :authenticate when action in [:index, :show]

  def index(conn, _params) do
    # case authenticate(conn) do
    #   %Plug.Conn{halted: true} = conn ->
    #     conn

    #   conn ->
        users = Accounts.list_users()
        # IO.inspect(users)
        render(conn, :index, users: users)
    # end
  end

  def show(conn, %{"id" => id}) do
    vid = String.to_integer(id)
    user = Accounts.get_user(vid)
    IO.inspect(id)
    IO.inspect(vid)
    IO.inspect(user)
    render(conn, :show, user: user)
  end

  def new(conn, _params) do
    changeset = Accounts.change_registration(%User{}, %{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        IO.inspect(user)
        IO.inspect(user_params)
        conn
        |> RumblWeb.Auth.login(user)
        |> put_flash(:info, "#{user.name} created!")
        |> redirect(to: ~p"/users")

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset)
        IO.inspect(user_params)
        render(conn, :new, changeset: changeset)
    end
  end

  defp authenticate(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access this page")
      |> redirect(to: ~p"/exams")
      |> halt()
    end
  end
end
