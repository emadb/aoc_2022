defmodule Aoc.Day02 do

  def part_one(input) do

    points = %{
      "X" => 1, "Y" => 2, "Z" => 3
    }

    InputReader.get_lines_string(input)
      |> Enum.map(&String.split(&1," "))
      |> Enum.reduce(0, fn [a, b], acc ->
        acc + win(a,b) + points[b]
      end)

  end

  # X = loose, Y = draw, Z = win

  # A = rock, B = paper, C = scissors
  # X = rock, Y = paper, Z = scissors

  defp win("A", "X"), do: 3
  defp win("A", "Y"), do: 6
  defp win("A", "Z"), do: 0
  defp win("B", "X"), do: 0
  defp win("B", "Y"), do: 3
  defp win("B", "Z"), do: 6
  defp win("C", "X"), do: 6
  defp win("C", "Y"), do: 0
  defp win("C", "Z"), do: 3

  def part_two(input) do
    input
  end
end
