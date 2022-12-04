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
    points = %{
      "X" => 1, "Y" => 2, "Z" => 3
    }

    InputReader.get_lines_string(input)
      |> Enum.map(&String.split(&1," "))
      |> Enum.reduce(0, fn [a, b], acc ->
        m = my_play(a,b)
        acc + win(a,m) + points[m]
      end)

  end

  # X = loose, Y = draw, Z = win

  # A = rock, B = paper, C = scissors
  # X = rock, Y = paper, Z = scissors

  defp my_play("A", "X"), do: "Z"
  defp my_play("A", "Y"), do: "X"
  defp my_play("A", "Z"), do: "Y"
  defp my_play("B", "X"), do: "X"
  defp my_play("B", "Y"), do: "Y"
  defp my_play("B", "Z"), do: "Z"
  defp my_play("C", "X"), do: "Y"
  defp my_play("C", "Y"), do: "Z"
  defp my_play("C", "Z"), do: "X"

end
