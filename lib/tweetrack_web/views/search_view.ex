defmodule TweetrackWeb.SearchView do
  use TweetrackWeb, :view

  def format_date(date) do
    if is_nil(date) do
      "-"
    else
      "#{date.day}/#{date.month}/#{date.year} #{date.hour}:#{date.minute}"
    end
  end
end
