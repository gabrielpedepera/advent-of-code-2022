defmodule RucksackReorganization do
  @moduledoc """
  Documentation for `RucksackReorganization`.
  """

  alias Impl.Organizer
  alias Impl.InputParser

  def score do
    organize()
    |> Organizer.score()
  end

  def score_badges do
    organize_by_badges()
    |> Organizer.score()
  end

  defp organize do
    {:ok, pid} = Organizer.start_link()

    InputParser.list()
    |> Enum.map(&Organizer.check_duplicated(pid, &1))

    pid
  end

  defp organize_by_badges do
    {:ok, pid} = Organizer.start_link()

    InputParser.chunked_by_three()
    |> Enum.map(&Organizer.check_badge(pid, &1))

    pid
  end
end
