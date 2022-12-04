defmodule Impl.InputParser do
  @items_list "assets/input.txt"
              |> File.read!()
              |> String.split(~r/\n/)

  def list do
    @items_list
    |> Enum.map(&split_items/1)
  end

  def chunked_by_three do
    @items_list
    |> Enum.chunk_every(3)
    |> Enum.map(&List.to_tuple/1)
    |> Enum.reject(fn x -> x == {""} end)
  end

  defp split_items(item) do
    split_at = trunc(String.length(item) / 2)

    item
    |> String.codepoints()
    |> Enum.split(split_at)
  end
end
