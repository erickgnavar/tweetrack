defmodule TweetrackWeb.PageControllerTest do
  use TweetrackWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert redirected_to(conn) == search_path(conn, :index)
  end
end
