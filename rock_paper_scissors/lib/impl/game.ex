defmodule Impl.Game do
  use GenServer

  alias Impl.Score

  def start_link(score \\ 0) do
    GenServer.start_link(__MODULE__, score)
  end

  def play(pid, {oponent, mine}) do
    GenServer.cast(pid, {:shape, mine})
    GenServer.call(pid, {:result, {oponent, mine}})
  end

  def score(pid) do
    GenServer.call(pid, :score)
  end

  @impl true
  def init(score) do
    {:ok, score}
  end

  @impl true
  def handle_cast({:shape, shape}, score) do
    {:noreply, score + Score.shape(shape)}
  end

  @impl true
  def handle_call({:result, {oponent, mine}}, _from, score) do
    {result, match_score} = Score.result(oponent, mine)
    {:reply, result, score + match_score }
  end

  @impl true
  def handle_call(:score, _from, score) do
    {:reply, score, score}
  end
end
