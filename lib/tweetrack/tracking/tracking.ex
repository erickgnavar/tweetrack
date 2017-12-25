defmodule Tweetrack.Tracking do
  @moduledoc """
  The Tracking context.
  """

  import Ecto.Query, warn: false
  alias Tweetrack.Repo

  alias Tweetrack.Tracking.{Search, Tweet}

  require Logger

  @doc """
  Returns the list of searches.

  ## Examples

      iex> list_searches()
      [%Search{}, ...]

  """
  def list_searches do
    Repo.all(Search)
  end

  @doc false
  def list_running_searches do
    Search
    |> where(status: "RUNNING")
    |> Repo.all
  end

  @doc """
  Gets a single search.

  Raises `Ecto.NoResultsError` if the Search does not exist.

  ## Examples

      iex> get_search!(123)
      %Search{}

      iex> get_search!(456)
      ** (Ecto.NoResultsError)

  """
  def get_search!(id), do: Repo.get!(Search, id)

  @doc """
  Creates a search.

  ## Examples

      iex> create_search(%{field: value})
      {:ok, %Search{}}

      iex> create_search(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_search(attrs \\ %{}) do
    %Search{}
    |> Search.changeset(attrs)
    |> Ecto.Changeset.put_change(:status, "PENDING")
    |> Repo.insert()
  end

  @doc """
  Updates a search.

  ## Examples

      iex> update_search(search, %{field: new_value})
      {:ok, %Search{}}

      iex> update_search(search, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_search(%Search{} = search, attrs) do
    search
    |> Search.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Search.

  ## Examples

      iex> delete_search(search)
      {:ok, %Search{}}

      iex> delete_search(search)
      {:error, %Ecto.Changeset{}}

  """
  def delete_search(%Search{} = search) do
    Repo.delete(search)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking search changes.

  ## Examples

      iex> change_search(search)
      %Ecto.Changeset{source: %Search{}}

  """
  def change_search(%Search{} = search) do
    Search.changeset(search, %{})
  end

  @doc """
  Start a process to read twitter stream api
  """
  def start_feed(%Search{} = search) do
    pid = Tweetrack.Twitter.start_stream(search)
    attrs = %{
      :status => "RUNNING",
      :pid => pid |> :erlang.pid_to_list |> to_string,
      :started_at => DateTime.utc_now |> DateTime.to_string
    }
    update_search(search, attrs)
  end

  @doc """
  Restart a process to read twitter stream api,
  a process may be dead because a timeout error by the twitter api
  """
  def restart_feed(%Search{} = search) do
    pid = search.pid |> to_charlist |> :erlang.list_to_pid
    if not Process.alive? pid do
      Logger.info "Search #{search.keyword} restarted!"
      pid = Tweetrack.Twitter.start_stream(search)
      attrs = %{
        :pid => pid |> :erlang.pid_to_list |> to_string,
      }
      update_search(search, attrs)
    end
  end

  def finish_feed(%Search{} = search) do
    pid = search.pid |> to_charlist |> :erlang.list_to_pid
    if Process.alive? pid do
      Process.exit pid, :kill
    end
    attrs = %{
      :status => "FINISHED",
      :pid => nil,
      :finished_at => DateTime.utc_now |> DateTime.to_string
    }
    update_search(search, attrs)
  end

  @doc """
  Returns the list of tweet.

  ## Examples

      iex> list_tweet()
      [%Tweet{}, ...]

  """
  def list_tweet(where_args \\ []) do
    Tweet
    |> where(^where_args)
    |> Repo.all
  end

  @doc """
  Gets a single tweet.

  Raises `Ecto.NoResultsError` if the Tweet does not exist.

  ## Examples

      iex> get_tweet!(123)
      %Tweet{}

      iex> get_tweet!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tweet!(id), do: Repo.get!(Tweet, id)

  @doc """
  Creates a tweet.

  ## Examples

      iex> create_tweet(%{field: value})
      {:ok, %Tweet{}}

      iex> create_tweet(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tweet(attrs \\ %{}) do
    %Tweet{}
    |> Tweet.changeset(attrs)
    |> Repo.insert()
  end

end
