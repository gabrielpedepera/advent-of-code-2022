defmodule CalorieCounting.Impl.CaloriesCounting do
  use GenServer

  def start_link(calories_sum \\ []) do
    GenServer.start_link(__MODULE__, calories_sum)
  end

  def process(pid, calories_list) do
    GenServer.call(pid, {:process, calories_list})
  end

  def highest(pid) do
    GenServer.call(pid, :highest)
  end

  def top_three(pid) do
    GenServer.call(pid, :top_three)
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call({:process, calories_list}, _from, state) do
    calories_sum =
      calories_list
      |> Enum.sum()

    {:reply, calories_sum, [calories_sum | state]}
  end

  @impl true
  def handle_call(:highest, _from, state) do
    calories_sort = Enum.sort(state, :desc)

    {:reply, hd(calories_sort), state}
  end

  @impl true
  def handle_call(:top_three, _form, state) do
    calories_sort = Enum.sort(state, :desc)
    [one, two, three | _tail] = calories_sort

    {:reply, Enum.sum([one, two, three]), state}
  end
end
