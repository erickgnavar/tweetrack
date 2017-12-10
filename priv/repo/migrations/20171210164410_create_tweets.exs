defmodule Tweetrack.Repo.Migrations.CreateTweets do
  use Ecto.Migration

  def change do
    create table(:tweets) do
      add :text, :string, null: false
      add :name, :string, null: false
      add :handle, :string, null: false
      add :tweeted_at, :naive_datetime, null: false
      add :latitude, :float
      add :longitude, :float
      add :profile_image_url, :string, null: false
      add :search_id, references(:searches, on_delete: :nothing)

      timestamps()
    end

    create index(:tweets, [:search_id])

  end
end
