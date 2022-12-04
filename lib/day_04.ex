defmodule Aoc.Day04 do
  def part_one(input) do
    InputReader.get_lines_string(input)
    |> Enum.map(fn s ->
      [r1, r2] = String.split(s, ",")
      completely_overlap?(get_range(r1), get_range(r2))
    end)
    |> Enum.count(fn x -> x end)
  end

  defp get_range(r) do
    [p1, p2] = String.split(r, "-")
    String.to_integer(p1)..String.to_integer(p2)
  end

  defp completely_overlap?(r1, r2) do
    s1 = Enum.to_list(r1) |> MapSet.new()
    s2 = Enum.to_list(r2) |> MapSet.new()

    MapSet.subset?(s1, s2) || MapSet.subset?(s2, s1)
  end

  def part_two(input) do
    InputReader.get_lines_string(input)
    |> Enum.map(fn s ->
      [r1, r2] = String.split(s, ",")
      overlap?(get_range(r1), get_range(r2))
    end)
    |> Enum.count(fn x -> x end)
  end

  defp overlap?(r1, r2) do
    l1 = Enum.to_list(r1) |> MapSet.new()
    l2 = Enum.to_list(r2) |> MapSet.new()

    MapSet.intersection(l1,l2) |> MapSet.size() > 0
  end
end
