defmodule Aoc.Day20 do
  def part_one(input) do
    initial_list = InputReader.get_lines_integer(input)

    size = Enum.count(initial_list)
    list = Enum.zip(initial_list, 0..size-1)

    IO.inspect list, label: :"INITIAL LIST"

    Enum.reduce(list, list, fn {e, i}, list ->
      new_list = move({e, i}, list, size)
      IO.inspect {e, Enum.map(new_list, fn {a, _b} -> a end)}
      new_list
    end)
  end





  def move(0, _index, list, _size), do: list

  def move({item, index}, list, size) do

    new_index = rem(index + item, size) - 1
    IO.inspect new_index, label: "#{item} - NI>>"

    new_index = if new_index < 0 do
      new_index + size - 1
    else
      new_index
    end

    list
    |> List.delete({item, index})
    |> List.insert_at(new_index, {item, index})
  end

  def part_two(input) do
    input
  end
end
