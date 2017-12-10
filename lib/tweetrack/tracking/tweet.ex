defmodule Tweetrack.Tracking.Tweet do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tweetrack.Tracking.{Tweet, Search}


  schema "tweets" do
    field :name, :string
    field :handle, :string
    field :text, :string
    field :tweeted_at, :naive_datetime
    field :latitude, :float
    field :longitude, :float
    field :profile_image_url, :string

    belongs_to :search, Search

    timestamps()
  end

  @doc false
  def changeset(%Tweet{} = tweet, attrs) do
    tweet
    |> cast(attrs, [:text, :name, :handle, :tweeted_at, :profile_image_url, :latitude, :longitude, :search_id])
    |> validate_required([:text, :name, :handle, :tweeted_at, :profile_image_url, :search_id])
  end
end
