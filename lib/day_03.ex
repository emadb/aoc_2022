defmodule Aoc.Day03 do

  def part_one(input) do
    InputReader.get_lines_string(input)
    |> Enum.map(fn l ->
      len = String.length(l)
      [String.slice(l, 0..div(len,2)-1), String.slice(l, div(len,2)..len)]
    end)
    |> Enum.map(fn [r1, r2] ->
      [String.graphemes(r1), String.graphemes(r2)]
    end)
    |> Enum.map(fn [r1, r2] ->
      r3 = r1 -- r2
      r1 -- r3
    end)
    |> Enum.map(&Enum.uniq/1)
    |> Enum.map(fn [l] -> priority(l) end)
    |> Enum.sum()
  end

  defp priority(char) do
    ascii = String.to_charlist(char) |> List.first()

    if String.upcase(char) == char do
      ascii - ?A + 27
    else
      ascii - ?a + 1
    end
  end


  def part_two(input) do
    InputReader.get_lines_string(input)
    |> Enum.chunk_every(3)
    |> Enum.map(fn [r1, r2, r3] ->
      s1 = r1 |> String.graphemes() |> MapSet.new()
      s2 = r2 |> String.graphemes() |> MapSet.new()
      s3 = r3 |> String.graphemes() |> MapSet.new()
      MapSet.intersection(s1, s2) |> MapSet.intersection(s3)
    end)
    |> Enum.map(&Enum.uniq/1)
    |> Enum.map(fn [l] -> priority(l) end)
    |> Enum.sum()
  end
end
