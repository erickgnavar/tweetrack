defmodule Tweetrack.Tracking do
  @moduledoc """
  The Tracking context.
  """

  import Ecto.Query, warn: false
  alias Tweetrack.Repo

  alias Tweetrack.Tracking.Search

  @doc """
  Returns the list of searches.

  ## Examples

      iex> list_searches()
      [%Search{}, ...]

  """
  def list_searches do
    Repo.all(Search)
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
end
