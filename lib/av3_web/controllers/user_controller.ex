defmodule Av3Web.UserController do

  use Av3Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def edit(conn, _params) do
    render(conn, "edit.html")
  end

end
