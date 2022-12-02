defmodule CalorieCounting do
  @moduledoc """
  Documentation for `CalorieCounting`.
  """

  alias CalorieCounting.Impl.CaloriesCounting
  alias CalorieCounting.Impl.CaloriesInput

  def highest do
    calculate()
    |> CaloriesCounting.highest()
  end

  def top_three do
    calculate()
    |> CaloriesCounting.top_three()
  end

  defp calculate do
    {:ok, pid} = CaloriesCounting.start_link()

    for calories_list <- CaloriesInput.list() do
      CaloriesCounting.process(pid, calories_list)
    end

    pid
  end
end
