defmodule TweetrackWeb.TweetController do
  use TweetrackWeb, :controller

  alias Tweetrack.Tracking

  action_fallback TweetrackWeb.FallbackController

  def index(conn, %{"search_id" => search_id}) do
    tweet = Tracking.list_tweet(search_id: search_id)
    render(conn, "index.json", tweet: tweet)
  end

  def show(conn, %{"id" => id}) do
    tweet = Tracking.get_tweet!(id)
    render(conn, "show.json", tweet: tweet)
  end

end
