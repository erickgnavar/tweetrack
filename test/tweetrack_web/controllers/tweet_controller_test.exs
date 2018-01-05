defmodule TweetrackWeb.TweetControllerTest do
  use TweetrackWeb.ConnCase

  alias Tweetrack.Tracking

  @valid_attrs %{name: "some name", handle: "somehandle", profile_image_url: "https://t.co", text: "test", tweeted_at: "2017-12-10 20:00:50.017816Z"}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do

    test "lists all tweet by search_id", %{conn: conn} do
      {:ok, search} = Tracking.create_search(%{keyword: "test"})
      attrs = @valid_attrs |> Map.put(:search_id, search.id)
      {:ok, tweet} = Tracking.create_tweet(attrs)
      conn = get conn, tweet_path(conn, :index), search_id: search.id
      assert length(json_response(conn, 200)["data"]) == 1
      res_tweet = List.first(json_response(conn, 200)["data"])
      assert res_tweet["id"] == tweet.id
    end
  end

end
