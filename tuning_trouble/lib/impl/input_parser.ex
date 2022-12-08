defmodule Impl.InputParser do
  @signal_input "assets/input.txt"
                |> File.read!()
                |> String.codepoints()
                |> Enum.reject(fn x -> x == "\n" end)

  def signal_input do
    @signal_input
  end
end
