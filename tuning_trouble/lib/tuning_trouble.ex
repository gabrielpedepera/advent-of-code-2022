defmodule TuningTrouble do
  @moduledoc """
  Documentation for `TuningTrouble`.
  """

  alias Impl.InputParser

  def find_start_of_packet do
    InputParser.signal_input()
    |> find_signal()
  end

  defp find_signal(signal_stream, index \\ 0) do
    sequence_identifier = 14
    sequence = Enum.take(signal_stream, sequence_identifier)
    
    if sequence_identifier == length(Enum.uniq(sequence)) do
      sequence_identifier + index
    else
      [_head | tail] = signal_stream
      find_signal(tail, index + 1)
    end
  end
end
