defmodule Aoc.Day18 do
  def part_one(input) do
    map = InputReader.get_lines_string(input)
    |> Enum.reduce(MapSet.new(), fn p, map ->
      [x, y, z] = String.split(p, ",")
      MapSet.put(map, {String.to_integer(x), String.to_integer(y), String.to_integer(z)})
    end)

    Enum.reduce(map, %{}, fn p, new_map ->
      neighbords = get_neighbords(p)
      busy_faces = Enum.count(neighbords, fn n -> MapSet.member?(map, n) end)
      Map.update(new_map, p, 6 - busy_faces, fn x -> x + (6 - busy_faces) end)
    end)
    |> Enum.reduce(0, fn {_p, pc}, acc -> acc + pc end)

  end

  defp get_neighbords({x, y, z}, func \\ fn x -> x end ) do
    [{x - 1, y, z}, {x + 1, y, z}, {x, y - 1, z}, {x, y + 1, z}, {x, y, z - 1}, {x, y, z + 1}]
    |> Enum.filter(func)
  end

  def part_two(input) do
    data = InputReader.get_lines_string(input)
    |> Enum.reduce(MapSet.new(), fn p, map ->
      [x, y, z] = String.split(p, ",")
      MapSet.put(map, {String.to_integer(x), String.to_integer(y), String.to_integer(z)})
    end)

    min_x = -1 + (data |> Enum.map(&elem(&1, 0)) |> Enum.min())
    min_y = -1 + (data |> Enum.map(&elem(&1, 1)) |> Enum.min())
    min_z = -1 + (data |> Enum.map(&elem(&1, 2)) |> Enum.min())
    max_x = 1 + (data |> Enum.map(&elem(&1, 0)) |> Enum.max())
    max_y = 1 + (data |> Enum.map(&elem(&1, 1)) |> Enum.max())
    max_z = 1 + (data |> Enum.map(&elem(&1, 2)) |> Enum.max())

    src = {min_x, min_y, min_z}

    exterior =
      search(
        MapSet.new([src]),
        :queue.in(src, :queue.new()),
        data,
        min_x..max_x,
        min_y..max_y,
        min_z..max_z
      )

    data
    |> Enum.map(fn point -> Enum.count(get_neighbords(point, &MapSet.member?(exterior, &1))) end)
    |> Enum.sum()
  end

  def search(found, queue, space, xbounds, ybounds, zbounds) do
    case :queue.out(queue) do
      {{:value, point}, queue} ->
        newfound =
          get_neighbords(
            point,
            &(not MapSet.member?(space, &1) and not MapSet.member?(found, &1) and
                in_bounds(&1, xbounds, ybounds, zbounds))
          )

        queue = Enum.reduce(newfound, queue, &:queue.in/2)
        found = Enum.reduce(newfound, found, &MapSet.put(&2, &1))
        search(found, queue, space, xbounds, ybounds, zbounds)

      {:empty, _queue} ->
        found
    end
  end

  def in_bounds({x, y, z}, xbounds, ybounds, zbounds) do
    x in xbounds and y in ybounds and z in zbounds
  end


end
