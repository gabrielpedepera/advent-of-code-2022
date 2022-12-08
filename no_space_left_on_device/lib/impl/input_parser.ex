defmodule Impl.InputParser do
  @commands "assets/input.txt"
            |> File.read!()
            |> String.split("\n", trim: true)

  def parse() do
    @commands
    |> Enum.reduce({nil, %{}}, &exec_line/2)
    |> then(fn {_, map} -> map end)
    |> Enum.to_list()
    |> size_map(%{})
  end

  defp exec_line("$ cd /", {_, dirs}), do: {[], dirs}
  defp exec_line("$ cd ..", {[_ | path], dirs}), do: {path, dirs}
  defp exec_line(<<"$ cd ", name::binary>>, {path, dirs}), do: {[name | path], dirs}
  defp exec_line(<<"$ ls">>, {path, dirs}), do: {path, Map.put(dirs, path, {[], []})}

  defp exec_line(<<"dir ", name::binary>>, {path, dirs}) do
    {path, Map.update!(dirs, path, fn {dirs, files} -> {[[name | path] | dirs], files} end)}
  end

  defp exec_line(file, {path, dirs}) do
    [size, name] = String.split(file)
    size = String.to_integer(size)
    {path, Map.update!(dirs, path, fn {dirs, files} -> {dirs, [{size, name} | files]} end)}
  end

  defp size_map(worklist, normalized) do
    if Enum.empty?(worklist) do
      normalized
    else
      [dir = {path, {children, files}} | worklist] = worklist

      if Enum.all?(children, &Map.has_key?(normalized, &1)) do
        files = Enum.reduce(files, 0, fn {size, _}, sum -> sum + size end)
        dirs = Enum.reduce(children, 0, fn name, sum -> sum + normalized[name] end)
        size_map(worklist, Map.put(normalized, path, dirs + files))
      else
        size_map(worklist ++ [dir], normalized)
      end
    end
  end
end
