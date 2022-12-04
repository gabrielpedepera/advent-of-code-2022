defmodule Impl.Dictionary do
  @dictionary_lowercases Enum.with_index(?a..?z, fn element, index ->
                           {String.to_atom(<<element::utf8>>), index + 1}
                         end)

  @dictionary_uppercases Enum.with_index(?A..?Z, fn element, index ->
                           {String.to_atom(<<element::utf8>>), index + 27}
                         end)

  @dictionary_values @dictionary_lowercases ++ @dictionary_uppercases

  def get_value(value) do
    @dictionary_values[value]
  end

  def dictionary_values do
    @dictionary_values
  end
end
