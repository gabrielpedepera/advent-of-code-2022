defmodule Impl.Organizer do
  use GenServer

  alias Impl.Dictionary

  def start_link(duplicated_items \\ []) do
    GenServer.start_link(__MODULE__, duplicated_items)
  end

  def check_duplicated(pid, {compartment1, compartment2}) do
    GenServer.cast(pid, {:check_duplicated, {compartment1, compartment2}})
  end

  def score(pid) do
    GenServer.call(pid, :score)
  end

  @impl true
  def init(duplicated_items) do
    {:ok, duplicated_items}
  end

  @impl true
  def handle_cast({:check_duplicated, {compartment1, compartment2}}, duplicated_items) do
    intersected_items = compartment1 -- (compartment1 -- compartment2)

    {:noreply, duplicated_items ++ Enum.uniq(intersected_items)}
  end

  @impl true
  def handle_call(:score, _from, duplicated_items) do
    IO.inspect(length(duplicated_items), label: "length: ")

    score =
      duplicated_items
      |> Enum.map(fn x -> Dictionary.get_value(String.to_atom(x)) end)
      |> Enum.sum()

    {:reply, score, duplicated_items}
  end
end
