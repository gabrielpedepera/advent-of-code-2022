defmodule Impl.InputParser do
  @section_camps "assets/input.txt"
                 |> File.read!()
                 |> String.split(~r/\n/, trim: true)

  def sections_pairs_assigned do
    for item <- @section_camps do
      [first, second] = String.split(item, ",")

      [start1, end1] = String.split(first, "-")
      [start2, end2] = String.split(second, "-")

      {String.to_integer(start1)..String.to_integer(end1),
       String.to_integer(start2)..String.to_integer(end2)}
    end
  end
end
