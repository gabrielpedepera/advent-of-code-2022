defmodule Impl.InputParser do
  @matches_list "assets/input.txt"
                |> File.read!()
                |> String.split(~r/\n/)

  def list do
    @matches_list
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.map(&List.to_tuple/1)
    |> Enum.reject(&(&1 == {}))
  end
end
