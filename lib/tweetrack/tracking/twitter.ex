defmodule Tweetrack.Twitter do
  @moduledoc false

  require Logger
  alias Tweetrack.Tracking

  @date_format "%a %b %d %H:%M:%S %z %Y"

  @doc false
  def start_stream(search) do
    Logger.info("Started for #{search.keyword}")
    spawn fn ->
      stream = ExTwitter.stream_filter(track: search.keyword)
      for tweet <- stream do
        save_tweet(tweet, search.id)
      end
    end
  end

  @doc false
  def save_tweet(tweet, search_id) do
    if is_nil(tweet.coordinates) do
      lng = nil
      lat = nil
    else
      [lng, lat] = tweet.coordinates.coordinates
    end

    tweeted_at = Timex.parse!(tweet.created_at, @date_format, :strftime)
    
    attrs = %{
      :text => tweet.text,
      :name => tweet.user.name,
      :handle => tweet.user.screen_name,
      :profile_image_url => tweet.user.profile_image_url,
      :tweeted_at => tweeted_at,
      :search_id => search_id,
      :latitude => lat,
      :longitude => lng,
    }
    spawn fn ->
      case Tracking.create_tweet(attrs) do
        {:error, _} ->
          Logger.error("Error when try to save #{inspect attrs}")
        _ ->
      end
    end
  end

end
