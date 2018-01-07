defmodule TweetrackWeb.PageController do
  use TweetrackWeb, :controller

  def index(conn, _params) do
    conn
    |> redirect(to: search_path(conn, :index))
  end
end
