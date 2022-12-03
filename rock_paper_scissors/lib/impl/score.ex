defmodule Impl.Score do
  @doc """
  "X" -> Rock  
  "Y" -> Paper
  "Z" -> Scissors
  """
  @shape_values %{
    rock: 1,
    paper: 2,
    scissors: 3
  }

  @dictionary_shapes %{
    "A" => :rock,
    "B" => :paper,
    "C" => :scissors,
    "X" => :rock,
    "Y" => :paper,
    "Z" => :scissors
  }

  @results %{
    won: 6,
    draw: 3,
    lost: 0
  }

  def shape(shape) do
    @shape_values[@dictionary_shapes[shape]]
  end

  def result(oponent, mine) do
    result = check_result(oponent, mine)
    {result, @results[result]}
  end

  defp check_result(oponent, mine) do
    oponent_move = @dictionary_shapes[oponent]
    my_move = @dictionary_shapes[mine]

    case oponent_move do
      ^my_move -> :draw
      _ -> check_combination({oponent_move, my_move})
    end
  end

  defp check_combination({:rock, :paper}) do
    :won
  end

  defp check_combination({:paper, :rock}) do
    :lost
  end

  defp check_combination({:rock, :scissors}) do
    :lost
  end

  defp check_combination({:scissors, :rock}) do
    :won
  end

  defp check_combination({:paper, :scissors}) do
    :won
  end

  defp check_combination({:scissors, :paper}) do
    :lost
  end
end
