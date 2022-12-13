defmodule Aoc.Day12 do

  def part_one(input) do
    map = InputReader.get_lines_string(input)
    |> Enum.with_index(&parse_line/2)
    |> Enum.flat_map(&(&1))
    |> Enum.reduce(%{}, fn m, acc ->
      k = get_key(m)
      Map.put_new(acc, k, m[k])
    end)


    {dest, _} = Enum.find(map, fn {_, v} -> v == 0 end)
    {start, _} = Enum.find(map, fn {_, v} -> v == 27 end)

    navigate(start, dest, map, [])
    |> IO.inspect
    |> Enum.count()
  end

 defp get_key(m), do: Map.keys(m) |> List.first()

  defp navigate({xs, ys}, {xd, yd}, _map, steps) when {xs, ys} == {xd, yd}, do: steps
  defp navigate({xs, ys}, {xd, yd}, map, steps) do
    Enum.reduce(candidates({xs, ys}, map, steps), [], fn {x, y}, acc ->
      acc ++ navigate({x, y}, {xd, yd}, map, steps ++ [{xs, ys}])
    end)
  end

  defp candidates({xc, yc}, map, steps) do
    [{-1, 0}, {1, 0}, {0, -1}, {0, 1}]
    |> Enum.map(fn {x, y} -> {xc + x, yc + y} end)
    |> Enum.filter(fn k -> Map.has_key?(map, k) end)
    |> Enum.filter(fn xy -> map[xy] - map[{xc, yc}] <= 1 end)
    |> Enum.reject(fn xy -> Enum.member?(steps, xy) end)
  end

  defp visited?(xy, steps) do
    Enum.member?(steps, xy)
  end

  defp parse_line(line, row_index) do
    chars = String.graphemes(line)
    Enum.with_index(chars, fn e, i ->
      case e do
        "S" ->  %{{row_index, i} => 0}
        "E" ->  %{{row_index, i} => 27}
        _ -> %{{row_index, i} => :binary.first(e) - ?a + 1}
      end
    end)
  end

  def part_two(input) do
    input
  end
end
