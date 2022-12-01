defmodule Aoc.Day01 do
  def part_one(input) do
    Enum.max(chunks(input))
  end

  def part_two(input) do
    [a, b, c | _] = Enum.sort(chunks(input), :desc)
    a + b + c
  end

  defp chunks(input) do
    content = InputReader.get_lines_string(input) ++ [""]

    {_, partials} = Enum.reduce(content, {0, []}, fn x, {current, list} ->
      case x do
        "" -> {0, [current | list] }
        _ -> {current + String.to_integer(x), list}
      end
    end)
    partials
  end

end
