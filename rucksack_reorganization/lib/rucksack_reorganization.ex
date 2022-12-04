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

  def organize do
    {:ok, pid} = Organizer.start_link()

    InputParser.list()
    |> Enum.map(&(Organizer.check_duplicated(pid, &1)))

    pid
  end
end
