defmodule NoSpaceLeftOnDevice do
  @moduledoc """
  Documentation for `NoSpaceLeftOnDevice`.
  """

  alias Impl.InputParser

  def sum_of_dirs_more_than(size \\ 100_000) do
    InputParser.parse()
    |> Enum.filter(fn {_, s} -> s <= size end)
    |> Enum.map(fn {_, s} -> s end)
    |> Enum.sum()
  end

  def size_of_smallest_dir_to_be_deleted do
    sizes = InputParser.parse()
    required = 30_000_000 - (70_000_000 - sizes[[]])

    sizes
    |> Enum.filter(fn {_, s} -> s >= required end)
    |> Enum.map(fn {_, s} -> s end)
    |> Enum.min()
  end
end
