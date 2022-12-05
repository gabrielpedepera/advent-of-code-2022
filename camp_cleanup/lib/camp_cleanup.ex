defmodule CampCleanup do
  @moduledoc """
  Documentation for `CampCleanup`.
  """

  alias Impl.InputParser
  alias Impl.AssignmentPair

  def count_overlaps do
    {:ok, pid} = AssignmentPair.start_link()

    for sections <- InputParser.sections_pairs_assigned() do
      AssignmentPair.overlap?(pid, sections)
    end

    AssignmentPair.count_overlaps(pid)
  end
end
