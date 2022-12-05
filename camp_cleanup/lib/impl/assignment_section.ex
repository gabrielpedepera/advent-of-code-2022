defmodule Impl.AssignmentSection do
  def overlap?([], _), do: false

  def overlap?(l1 = [_ | t], l2) do
    List.starts_with?(l1, l2) or overlap?(t, l2)
  end
end
