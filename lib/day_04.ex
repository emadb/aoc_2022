defmodule Aoc.Day04 do
  def part_one(input) do
    InputReader.get_lines_string(input)
    |> Enum.map(fn s ->
      [r1, r2] = String.split(s, ",")
      overlap?(get_range(r1), get_range(r2))
    end)
    |> Enum.count(fn x -> x end)
  end

  defp get_range(r) do
    [p1, p2] = String.split(r, "-")
    String.to_integer(p1)..String.to_integer(p2)
  end

  defp overlap?(r1, r2) do
    r1_first = r1 |> Enum.to_list() |> List.first()
    r1_last = r1 |> Enum.to_list() |> List.last()

    r2_first = r2 |> Enum.to_list() |> List.first()
    r2_last = r2 |> Enum.to_list() |> List.last()

    r1_contains_r2 = r1_first <= r2_first && r1_last >= r2_last
    r2_contains_r1 = r2_first <= r1_first && r2_last >= r1_last

    r1_contains_r2 || r2_contains_r1
  end

  def part_two(input) do
    input
  end
end
