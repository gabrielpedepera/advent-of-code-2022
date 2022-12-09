defmodule Impl.InputParser do
  @trees_matrix "assets/input.txt"
                |> File.read!()
                |> String.split(~r/\n/, trim: true)

  def input_parsed() do
    @trees_matrix
    |> Enum.map(&String.codepoints/1)
    |> Enum.map(fn x -> Enum.map(x, &String.to_integer/1) end)
  end
end
