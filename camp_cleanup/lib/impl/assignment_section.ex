defmodule Impl.AssignmentSection do
  def full_overlap?([], _), do: false

  def full_overlap?(l1 = [_ | t], l2) do
    List.starts_with?(l1, l2) or full_overlap?(t, l2)
  end

  def overlap?(range1, range2) do
    !Range.disjoint?(range1, range2) 
  end
end
