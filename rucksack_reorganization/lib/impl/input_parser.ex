defmodule Impl.InputParser do
  @items_list "assets/input.txt"
              |> File.read!()
              |> String.split(~r/\n/)

  def list do
    @items_list
    |> Enum.map(&split_items/1)
  end

  defp split_items(item) do
    split_at = trunc(String.length(item) / 2)

    item
    |> String.codepoints()
    |> Enum.split(split_at)
  end
end
