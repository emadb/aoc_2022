defmodule Aoc.Day01 do
  def part_one(input) do
    content = InputReader.get_lines_string(input)

    {_, partials} = Enum.reduce(content, {0, []}, fn x, {current, list} ->
      case x do
        "" -> {0, [current | list] }
        _ -> {current + String.to_integer(x), list}
      end
    end)

    Enum.max(partials)
  end

  def part_two(input) do
    content = InputReader.get_lines_string(input) ++ [""]

    {_, partials} = Enum.reduce(content, {0, []}, fn x, {current, list} ->
      case x do
        "" -> {0, [current | list] }
        _ -> {current + String.to_integer(x), list}
      end
    end)

    [a, b, c | _] = Enum.sort(partials, :desc)
    a + b + c
  end


end
