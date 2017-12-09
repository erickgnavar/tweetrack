defmodule TweetrackWeb.SearchController do
  use TweetrackWeb, :controller

  alias Tweetrack.Tracking
  alias Tweetrack.Tracking.Search

  def index(conn, _params) do
    searches = Tracking.list_searches()
    render(conn, "index.html", searches: searches)
  end

  def new(conn, _params) do
    changeset = Tracking.change_search(%Search{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"search" => search_params}) do
    case Tracking.create_search(search_params) do
      {:ok, search} ->
        conn
        |> put_flash(:info, "Search created successfully.")
        |> redirect(to: search_path(conn, :show, search))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    search = Tracking.get_search!(id)
    render(conn, "show.html", search: search)
  end

  def edit(conn, %{"id" => id}) do
    search = Tracking.get_search!(id)
    changeset = Tracking.change_search(search)
    render(conn, "edit.html", search: search, changeset: changeset)
  end

  def update(conn, %{"id" => id, "search" => search_params}) do
    search = Tracking.get_search!(id)

    case Tracking.update_search(search, search_params) do
      {:ok, search} ->
        conn
        |> put_flash(:info, "Search updated successfully.")
        |> redirect(to: search_path(conn, :show, search))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", search: search, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    search = Tracking.get_search!(id)
    {:ok, _search} = Tracking.delete_search(search)

    conn
    |> put_flash(:info, "Search deleted successfully.")
    |> redirect(to: search_path(conn, :index))
  end
end
