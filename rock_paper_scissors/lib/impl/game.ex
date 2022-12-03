defmodule Impl.Game do
  use GenServer

  alias Impl.Score

  def start_link(score \\ 0) do
    GenServer.start_link(__MODULE__, score)
  end

  def play(pid, {oponent, instruction}) do
    GenServer.cast(pid, {:shape, {oponent, instruction}})
    GenServer.call(pid, {:result, {oponent, instruction}})
  end

  def score(pid) do
    GenServer.call(pid, :score)
  end

  @impl true
  def init(score) do
    {:ok, score}
  end

  @impl true
  def handle_cast({:shape, {oponent, instruction}}, score) do
    {:noreply, score + Score.shape(oponent, instruction)}
  end

  @impl true
  def handle_call({:result, {oponent, instruction}}, _from, score) do
    {result, match_score} = Score.result(oponent, instruction)
    {:reply, result, score + match_score }
  end

  @impl true
  def handle_call(:score, _from, score) do
    {:reply, score, score}
  end
end
