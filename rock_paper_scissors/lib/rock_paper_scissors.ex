defmodule RockPaperScissors do
  @moduledoc """
  Documentation for `RockPaperScissors`.
  """
  alias Impl.Game
  alias Impl.InputParser

  def toal_score do
    process()
    |> Game.score()
  end

  defp process do
    {:ok, pid} = Game.start_link()

    for match <- InputParser.list() do
      Game.play(pid, match)
    end

    pid
  end
end
