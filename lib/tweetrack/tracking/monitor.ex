defmodule Tweetrack.Tracking.Monitor do
  use GenServer

  require Logger
  alias Tweetrack.Tracking

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    Logger.info "Tracking monitor started!"
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, state) do
    searches = Tracking.list_running_searches()

    for search <- searches do
      Tracking.restart_feed(search)
    end

    schedule_work()
    {:noreply, state}
  end

  def schedule_work do
    Process.send_after(self(), :work, 30 * 1000)  # 30 seconds
  end
end
