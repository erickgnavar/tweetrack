defmodule Tweetrack.TrackingTest do
  use Tweetrack.DataCase

  alias Tweetrack.Tracking

  describe "searches" do
    alias Tweetrack.Tracking.Search

    @valid_attrs %{keyword: "some keyword"}
    @update_attrs %{keyword: "some updated keyword", pid: "some updated pid", status: "some updated status"}
    @invalid_attrs %{keyword: nil, pid: nil, status: nil}

    def search_fixture(attrs \\ %{}) do
      {:ok, search} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tracking.create_search()

      search
    end

    test "list_searches/0 returns all searches" do
      search = search_fixture()
      assert Tracking.list_searches() == [search]
    end

    test "get_search!/1 returns the search with given id" do
      search = search_fixture()
      assert Tracking.get_search!(search.id) == search
    end

    test "create_search/1 with valid data creates a search" do
      assert {:ok, %Search{} = search} = Tracking.create_search(@valid_attrs)
      assert search.keyword == "some keyword"
      assert search.status == "PENDING"
    end

    test "create_search/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracking.create_search(@invalid_attrs)
    end

    test "update_search/2 with valid data updates the search" do
      search = search_fixture()
      assert {:ok, search} = Tracking.update_search(search, @update_attrs)
      assert %Search{} = search
      assert search.keyword == "some updated keyword"
      assert search.pid == "some updated pid"
      assert search.status == "some updated status"
    end

    test "update_search/2 with invalid data returns error changeset" do
      search = search_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracking.update_search(search, @invalid_attrs)
      assert search == Tracking.get_search!(search.id)
    end

    test "delete_search/1 deletes the search" do
      search = search_fixture()
      assert {:ok, %Search{}} = Tracking.delete_search(search)
      assert_raise Ecto.NoResultsError, fn -> Tracking.get_search!(search.id) end
    end

    test "change_search/1 returns a search changeset" do
      search = search_fixture()
      assert %Ecto.Changeset{} = Tracking.change_search(search)
    end
  end
end
