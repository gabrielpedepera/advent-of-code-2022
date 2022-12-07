defmodule Impl.SuplyStacks do
  use GenServer

  def start_link(stacks \\ []) do
    GenServer.start(__MODULE__, stacks)
  end

  def rearrange(pid, instruction) do
    GenServer.cast(pid, {:rearrange, instruction})
  end

  def message(pid) do
    GenServer.call(pid, :message)
  end

  @impl true
  def init(stacks) do
    {:ok, stacks}
  end

  @impl true
  def handle_cast({:rearrange, instruction}, stacks) do
    {crates, from, to} = instruction

    counter_stacks =
      for _x <- 1..String.to_integer(crates), reduce: stacks do
        acc ->
          from_key = String.to_atom(from)
          to_key = String.to_atom(to)

          [from_head | from_tail] = acc[from_key]
          to_list = [from_head | acc[to_key]]

          %{acc | from_key => from_tail, to_key => to_list}
      end

    {:noreply, counter_stacks}
  end

  @impl true
  def handle_call(:message, _from, stacks) do
    message =
      Enum.map(Map.keys(stacks), fn x ->
        stacks[x]
        |> List.first()
      end)

    {:reply, Enum.join(message, ""), stacks}
  end
end
