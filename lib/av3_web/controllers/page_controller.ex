defmodule Av3Web.PageController do
  use Av3Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
