defmodule RumblWeb.ExamController do
  use RumblWeb, :controller

  def new(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :new)
  end

  def index(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :index, layout: false)
  end
end
