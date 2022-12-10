defmodule Aoc.Day10 do
  def part_one(input) do
    list = InputReader.get_lines_string(input)
    |> Enum.flat_map(&parse_line/1)
    |> Enum.scan(1, fn x,n -> n + x end)
    |> then(&[1 | &1])

    Enum.at(list, 19) * 20 +
    Enum.at(list, 59) * 60 +
    Enum.at(list, 99) * 100 +
    Enum.at(list, 139) * 140 +
    Enum.at(list, 179) * 180 +
    Enum.at(list, 219) * 220


  end

  defp parse_line("noop"), do: [0]

  defp parse_line("addx " <> value) do
    [0, String.to_integer(value)]
  end

  def part_two(input) do
    input
  end
end
