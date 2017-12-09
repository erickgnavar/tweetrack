defmodule Tweetrack.Repo.Migrations.AddProcessTimestampToSearchSchema do
  use Ecto.Migration

  def change do
    alter table(:searches) do
      add :started_at, :naive_datetime
      add :finished_at, :naive_datetime
    end

  end
end
