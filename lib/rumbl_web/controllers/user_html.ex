defmodule RumblWeb.UserHTML do
  use RumblWeb, :html

  alias Rumbl.Accounts

  def first_name(%Accounts.User{name: name}) do
    name
    |> String.split(" ")
    |> Enum.at(0)
  end

  def singleUser(assigns) do
    ~H"""
    <b><%= first_name(@user) %></b> (<%= @user.id %>)
    """
  end

  embed_templates "user_html/*"
end
