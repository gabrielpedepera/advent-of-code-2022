defmodule Impl.Organizer do
  use GenServer

  alias Impl.Dictionary

  def start_link(items \\ []) do
    GenServer.start_link(__MODULE__, items)
  end

  def check_duplicated(pid, {compartment1, compartment2}) do
    GenServer.cast(pid, {:check_duplicated, {compartment1, compartment2}})
  end

  def check_badge(pid, {items1, items2, items3}) do
    GenServer.cast(pid, {:check_badge, {items1, items2, items3}})
  end

  def score(pid) do
    GenServer.call(pid, :score)
  end

  @impl true
  def init(items) do
    {:ok, items}
  end

  @impl true
  def handle_cast({:check_duplicated, {compartment1, compartment2}}, items) do
    intersected_items = compartment1 -- compartment1 -- compartment2

    {:noreply, items ++ Enum.uniq(intersected_items)}
  end

  @impl true
  def handle_cast({:check_badge, {items1, items2, items3}}, items) do
    items1 = String.codepoints(items1)
    items2 = String.codepoints(items2)
    items3 = String.codepoints(items3)

    intersected_items =
      items1
      |> Enum.filter(fn elem -> Enum.member?(items2, elem) && Enum.member?(items3, elem) end)

    {:noreply, items ++ Enum.uniq(intersected_items)}
  end

  @impl true
  def handle_call(:score, _from, items) do
    score =
      items
      |> Enum.map(fn x -> Dictionary.get_value(String.to_atom(x)) end)
      |> Enum.sum()

    {:reply, score, items}
  end
end
