defmodule RumblWeb.SessionController do
  use RumblWeb, :controller

  # def new(conn, _params) do
  #   render(conn, :new)
  # end

  def index(conn, _) do
    render(conn, :index)
  end

  def home(conn, _) do
    render(conn, :home)
  end

  def create(
    conn,
    %{"session" => %{"username" => username, "password" => pass}}
  ) do
    case Rumbl.Accounts.authenticate_by_username_and_pass(username, pass) do
      {:ok, user} ->
        conn
        |> RumblWeb.Auth.login(user)
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: ~p"/exams")

        {:error, _reason} ->
          conn
          |> put_flash(:error, "Invalid username/password combination")
          |> render(:new)
    end
  end
end
