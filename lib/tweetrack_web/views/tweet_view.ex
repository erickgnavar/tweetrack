defmodule TweetrackWeb.TweetView do
  use TweetrackWeb, :view
  alias TweetrackWeb.TweetView

  def render("index.json", %{tweet: tweet}) do
    %{data: render_many(tweet, TweetView, "tweet.json")}
  end

  def render("show.json", %{tweet: tweet}) do
    %{data: render_one(tweet, TweetView, "tweet.json")}
  end

  def render("tweet.json", %{tweet: tweet}) do
    %{
      id: tweet.id,
      text: tweet.text,
      name: tweet.name,
      handle: tweet.handle,
      latitude: tweet.latitude,
      longitude: tweet.longitude,
      tweeted_at: tweet.tweeted_at,
      profile_image_url: tweet.profile_image_url,
    }
  end
end
