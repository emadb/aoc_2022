defmodule Aoc.Day08 do
  def part_one(input) do
    data = input
    |> InputReader.get_lines_string()
    |> Enum.map(fn s -> String.graphemes(s) |> Enum.map(&String.to_integer/1) end)

    rows = Enum.count(data) - 1
    cols = Enum.count(Enum.at(data, 0)) - 1

    map = build_map(data, rows, cols)

    Enum.reduce(map, [], fn {{r, c} ,v}, acc ->
      case {r, c} do
        {0, _} -> acc ++ [%{{r, c} => v}]
        {_, 0} -> acc ++ [%{{r, c} => v}]
        {^rows, _} -> acc ++ [%{{r, c} => v}]
        {_, ^cols} -> acc ++ [%{{r, c} => v}]
        {_, _} -> acc ++ check_height(r, c, v, map, rows, cols)
      end
    end)
    |> Enum.uniq()
    |> Enum.count()
  end

  defp check_height(r, c, v, map, rows, cols) do
    check_right(r, c, v, map, cols)
    ++ check_left(r, c, v, map, 0)
    ++ check_down(r, c, v, map, rows)
    ++ check_up(r, c, v, map, 0)
  end

  defp check_right(r, c, v, map, cols) do
    if (Enum.reduce(c+1..cols, true, fn y, acc -> acc && (map[{r, y}] < v) end)) do
      [%{{r, c} => v}]
    else
      []
    end
  end

  defp check_left(r, c, v, map, cols) do
    if (Enum.reduce(c-1..cols, true, fn y, acc -> acc && (map[{r, y}] < v) end)) do
      [%{{r, c} => v}]
    else
      []
    end
  end

  defp check_down(r, c, v, map, rows) do
    if (Enum.reduce(r+1..rows, true, fn x, acc -> acc && (map[{x, c}] < v) end)) do
      [%{{r, c} => v}]
    else
      []
    end
  end
  defp check_up(r, c, v, map, rows) do
    if (Enum.reduce(r-1..rows, true, fn x, acc -> acc && (map[{x, c}] < v) end)) do
      [%{{r, c} => v}]
    else
      []
    end
  end


  defp build_map(data, rows, cols) do

    coords = for r <- 0..rows do
      for c <- 0..cols do
        {r, c}
      end
    end

    list = Enum.zip(data, coords)
    |> Enum.flat_map(fn {d, c} ->
      Enum.zip_with(d, c, fn a, b ->
        %{b => a}
      end)
    end)

    Enum.reduce(list, %{}, fn e, acc -> Map.merge(acc, e) end)

  end

  def part_two(input) do
    data = input
    |> InputReader.get_lines_string()
    |> Enum.map(fn s -> String.graphemes(s) |> Enum.map(&String.to_integer/1) end)

    rows = Enum.count(data) - 1
    cols = Enum.count(Enum.at(data, 0)) - 1

    map = build_map(data, rows, cols)

    Enum.reduce(map, [], fn {{r, c} ,v}, acc ->
      acc ++ [extract_lower_trees(r, c, v, map, rows, cols)]
    end)
    |> Enum.max()
  end

  defp extract_lower_trees(0, _c, _v, _map, _rows, _cols), do: 0
  defp extract_lower_trees(_r, 0, _v, _map, _rows, _cols), do: 0
  defp extract_lower_trees(r, _c, _v, _map, rows, _cols) when r == rows, do: 0
  defp extract_lower_trees(_r, c, _v, _map, _rows, cols) when c == cols, do: 0

  defp extract_lower_trees(r, c, v, map, rows, cols) do
    right = Enum.reduce_while(c+1..cols, [], fn y, acc ->
      t = [%{{r, y} => map[{r, y}]}]
      if map[{r, y}] < v, do: {:cont, acc ++ t}, else: {:halt, acc ++ t}
    end)

    left = Enum.reduce_while(c-1..0, [], fn y, acc ->
      t = [%{{r, y} => map[{r, y}]}]
      if map[{r, y}] < v, do: {:cont, acc ++ t}, else: {:halt, acc ++ t}
    end)

    down = Enum.reduce_while(r+1..rows, [], fn x, acc ->
      t = [%{{x, c} => map[{x, c}]}]
      if map[{x, c}] < v, do: {:cont, acc ++ t}, else: {:halt, acc ++ t}
    end)

    up = Enum.reduce_while(r-1..0, [], fn x, acc ->
      t = [%{{x, c} => map[{x, c}]}]
      if map[{x, c}] < v, do: {:cont, acc ++ t}, else: {:halt, acc ++ t}
    end)

    Enum.count(right) * Enum.count(left) * Enum.count(down) * Enum.count(up)
  end
end
