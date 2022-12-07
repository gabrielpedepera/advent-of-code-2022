defmodule SuplyStacks do
  @moduledoc """
  Documentation for `SuplyStacks`.
  """
  alias Impl.InputParser
  alias Impl.SuplyStacks

  def rearranging do
    {stacks, instructions} = InputParser.data()
    {:ok, pid} = SuplyStacks.start_link(stacks)

    for instruction <- instructions do
      SuplyStacks.rearrange(pid, instruction) 
    end

    SuplyStacks.message(pid)
  end
end
