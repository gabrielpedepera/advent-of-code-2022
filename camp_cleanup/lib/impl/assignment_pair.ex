defmodule Impl.AssignmentPair do
  use GenServer

  alias Impl.AssignmentSection

  def start_link(overlaps \\ 0) do
    GenServer.start_link(__MODULE__, overlaps)
  end

  def count_overlaps(pid) do
    GenServer.call(pid, :count_overlaps)
  end

  def overlap?(pid, {section1, section2}) do
    GenServer.cast(pid, {:overlap?, section1, section2})
  end

  @impl true
  def init(overlaps) do
    {:ok, overlaps}
  end

  @impl true
  def handle_call(:count_overlaps, _from, overlaps) do
    {:reply, overlaps, overlaps}
  end

  @impl true
  def handle_cast({:overlap?, section1, section2}, overlaps) do
    overlapped =
      case AssignmentSection.overlap?(Enum.to_list(section1), Enum.to_list(section2)) do
        true -> true
        false -> AssignmentSection.overlap?(Enum.to_list(section2), Enum.to_list(section1))
      end
    
    overlaps = if overlapped, do: overlaps + 1, else: overlaps
    

    {:noreply, overlaps}
  end
end
