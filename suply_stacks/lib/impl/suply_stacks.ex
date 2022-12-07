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

    taken = Enum.take(stacks[String.to_atom(from)], String.to_integer(crates))

    to_list = List.flatten([taken | stacks[String.to_atom(to)]])
    from_list = stacks[String.to_atom(from)] -- taken

    {:noreply,
     %{
       stacks
       | String.to_atom(to) => to_list,
         String.to_atom(from) => from_list
     }}
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
