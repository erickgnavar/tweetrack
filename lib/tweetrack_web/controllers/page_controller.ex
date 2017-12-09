defmodule TweetrackWeb.PageController do
  use TweetrackWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
