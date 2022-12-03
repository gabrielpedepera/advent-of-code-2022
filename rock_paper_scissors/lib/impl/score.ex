defmodule Impl.Score do
  @shape_values %{
    rock: 1,
    paper: 2,
    scissors: 3
  }

  @dictionary_shapes %{
    "A" => :rock,
    "B" => :paper,
    "C" => :scissors
  }

  @results %{
    won: 6,
    draw: 3,
    lost: 0
  }

  @instructions %{
    "X" => :lost,
    "Y" => :draw,
    "Z" => :won
  }

  def shape(oponent, instruction) do
    movement = pick_movement(@dictionary_shapes[oponent], @instructions[instruction])
    @shape_values[movement]
  end

  def result(oponent, instruction) do
    result = check_result(oponent, instruction)
    {result, @results[result]}
  end

  defp check_result(oponent, instruction) do
    oponent_move = @dictionary_shapes[oponent]
    my_move = pick_movement(oponent_move, @instructions[instruction])

    case oponent_move do
      ^my_move -> :draw
      _ -> check_combination({oponent_move, my_move})
    end
  end

  defp pick_movement(oponent, instruction) do
    case instruction do
       :draw -> oponent
       :lost -> lost_movement(oponent)  
       :won -> win_movement(oponent)  
    end
  end

  defp lost_movement(:paper), do: :rock
  defp lost_movement(:rock), do: :scissors
  defp lost_movement(:scissors), do: :paper

  defp win_movement(:paper), do: :scissors
  defp win_movement(:rock), do: :paper
  defp win_movement(:scissors), do: :rock

  defp check_combination({:rock, :paper}), do: :won
  defp check_combination({:paper, :rock}), do: :lost
  defp check_combination({:rock, :scissors}), do: :lost
  defp check_combination({:scissors, :rock}), do: :won
  defp check_combination({:paper, :scissors}), do: :won
  defp check_combination({:scissors, :paper}), do: :lost
end
