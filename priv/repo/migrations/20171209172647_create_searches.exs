defmodule Tweetrack.Repo.Migrations.CreateSearches do
  use Ecto.Migration

  def change do
    create table(:searches) do
      add :keyword, :string
      add :status, :string
      add :pid, :string

      timestamps()
    end

  end
end
