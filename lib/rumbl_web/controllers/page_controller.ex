defmodule RumblWeb.PageController do
  use RumblWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def new(conn, _) do
    render(conn, :new)
  end

  def index(conn, _params) do
    render(conn, :new, layout: false)
  end
end
