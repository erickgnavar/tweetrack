defmodule Tweetrack.Tracking.Search do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tweetrack.Tracking.Search


  schema "searches" do
    field :keyword, :string
    field :pid, :string
    field :status, :string
    field :started_at, :naive_datetime
    field :finished_at, :naive_datetime

    timestamps()
  end

  @doc false
  def changeset(%Search{} = search, attrs) do
    search
    |> cast(attrs, [:keyword, :status, :pid, :started_at, :finished_at])
    |> validate_required([:keyword])
  end
end
