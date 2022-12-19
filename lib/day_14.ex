defmodule Aoc.Day14 do
  def part_one(input) do
    map = build_map(input)

    floor =
      map
      |> MapSet.to_list()
      |> Enum.map(&elem(&1, 0))
      |> Enum.max()
      |> Kernel.+(1)


    {_final_map, counter} = start_drop_sand(map, floor, :fall)
    counter
  end

  defp start_drop_sand(map, floor, mode, count \\ 0) do
    if MapSet.member?(map, {0, 500}) do
      {map, count}
    else
      {map, success} = drop_sand(map, floor, mode, {0, 500})

      if success do
        start_drop_sand(map, floor, mode, count + 1)
      else
        {map, count}
      end
    end
  end

  defp drop_sand(map, floor, mode, {x, y}) do
    final_place = sand_final_place(map, floor, mode, {x, y})

    case final_place do
      nil -> {map, false}
      {x, y} -> {MapSet.put(map, {x, y}), true}
    end
  end

  def sand_final_place(grid, floor, mode, {r, c}) do
    np = sand_on_the_floor(grid, floor, mode, {r, c})
    cond do
      np == nil -> nil
      np == {r, c} -> {r, c}
      true -> sand_final_place(grid, floor, mode, np)
    end
  end

  def sand_on_the_floor(grid, floor, mode, {x, y}) do
    cond do
      x == floor and mode == :fall -> nil
      x == floor and mode == :floor -> {x, y}
      !MapSet.member?(grid, {x + 1, y}) -> {x + 1, y}
      !MapSet.member?(grid, {x + 1, y - 1}) -> {x + 1, y - 1}
      !MapSet.member?(grid, {x + 1, y + 1}) -> {x + 1, y + 1}
      true -> {x, y}
    end
  end

  defp build_map(input) do
    InputReader.get_lines_string(input)
    |> Enum.map(&parse_line/1)
    |> Enum.reduce([], &++/2)
    |> Enum.map(fn [[cs, rs], [ce, re]] -> for r <- rs..re, c <- cs..ce, do: {r, c} end)
    |> List.flatten()
    |> Enum.into(MapSet.new())
  end

  def parse_line(line) do
    line
    |> ints()
    |> Enum.chunk_every(2)
    |> Enum.chunk_every(2, 1, :discard)
  end
  def ints(s) do
    Regex.scan(~r/\d+/, s)
    |> Enum.map(&hd/1)
    |> Enum.map(&String.to_integer/1)
  end

  def part_two(input) do
    map = build_map(input)

    floor =
      map
      |> MapSet.to_list()
      |> Enum.map(&elem(&1, 0))
      |> Enum.max()
      |> Kernel.+(1)


    {_final_map, counter} = start_drop_sand(map, floor, :floor)
    counter
  end
end
