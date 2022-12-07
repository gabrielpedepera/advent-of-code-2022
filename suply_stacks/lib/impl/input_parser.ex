defmodule Impl.InputParser do
  @stack_data "assets/input.txt"
              |> File.read!()
              |> String.split(~r/\n/)

  def data() do
    [stacks, instructions] =
      @stack_data
      |> Enum.chunk_by(fn x -> x == "" end)
      |> Enum.reject(fn x -> x == [""] end)

    {parse_stacks(stacks), parse_instructions(instructions)}
  end

  defp parse_instructions(instructions) do
    for instruction <- instructions do
      instruction
      |> String.split(" ")
      |> Enum.filter(&Regex.match?(~r/^\d/, &1))
      |> List.to_tuple()
    end
  end

  defp parse_stacks(stacks) do
    [counters | stacks] =
      stacks
      |> Enum.reverse()

    counter_stacks =
      counters
      |> String.split(" ", trim: true)
      |> Map.new(fn x -> {String.to_atom(x), []} end)

    counter_stacks =
      Enum.reduce(stacks, counter_stacks, fn stack, acc ->
        for x <- Map.keys(acc), reduce: acc do
          acc ->
            box = String.at(stack, find_position(x))

            if String.match?(box, ~r/[A-Z]/) do
              Map.put(acc, x, [box | acc[x]])
            else
              acc
            end
        end
      end)

    counter_stacks
  end

  defp find_position(stack) do
    index = stack |> Atom.to_string() |> String.to_integer()
    if index == 1, do: index, else: 3 * (index - 1) + index
  end
end
