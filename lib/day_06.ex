defmodule Aoc.Day06 do
  def part_one(input) do
    count_marker(input, 4)
  end

  def part_two(input) do
    count_marker(input, 14)
  end

  defp count_marker(input, count) do
    input
    |> File.read!()
    |> String.graphemes()
    |> Enum.chunk_every(count, 1)
    |> Enum.reduce_while(count, fn x, acc ->
      case x |> Enum.uniq() |> Enum.count() == count do
        true -> {:halt, acc}
        false -> {:cont, acc + 1}
      end
    end)

  end
end
