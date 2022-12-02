defmodule CalorieCounting.Impl.CaloriesInput do
  @calories_list "assets/input.txt"
                 |> File.read!()
                 |> String.split(~r/\n/)

  def list do
    @calories_list
    |> Enum.chunk_by(fn x -> x == "" end)
    |> Enum.reject(fn x -> x == [""] end)
    |> Enum.map(fn inner_list -> Enum.map(inner_list, &String.to_integer/1) end)
  end
end
