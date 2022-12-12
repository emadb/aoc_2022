defmodule Aoc.Day11 do


  def part_one(input) do
    1..20 |> Enum.reduce(input, fn _round, monkeys ->
      Enum.reduce(Map.keys(monkeys), monkeys, fn k, mm ->
        mm = Map.put(mm, k, Map.update!(mm[k], :count, &(&1 + Enum.count(mm[k].items))))
        items_to_pass = play(mm[k])
        mm = Map.put(mm, k, Map.put(mm[k], :items, []))
        execute_throw(items_to_pass, mm)
      end)
    end)
    |> Enum.map(fn {k, v} -> {k, v.count} end)
    |> Enum.sort_by(fn {_, v} -> v end, :desc)
    |> Enum.take(2)
    |> Enum.reduce(1, fn {_, v}, acc -> v * acc end)
  end

  defp play(m, relief\\3) do
    Enum.map(m.items, fn item ->
      worry_level = div(m.op.(item), relief)
      pass_to = m.test.(worry_level)
      {pass_to, worry_level}
    end)
  end

  defp execute_throw([], monkeys), do: monkeys
  defp execute_throw([{dest, worry} | rest], monkeys) do
    new_monkeys = Map.put(monkeys, dest, Map.put(monkeys[dest], :items, monkeys[dest].items ++ [worry]))
    execute_throw(rest, new_monkeys)
  end

  def part_two(input) do
    1..10000 |> Enum.reduce(input, fn round, monkeys ->
      # IO.inspect round
      Enum.reduce(Map.keys(monkeys), monkeys, fn k, mm ->
        items_to_pass = play(mm[k], 1)

        updated_monkey =
          mm[k]
          |> Map.update!(:count, &(&1 + Enum.count(mm[k].items)))
          |> Map.put(:items, [])
        mm = Map.put(mm, k, updated_monkey)

        execute_throw(items_to_pass, mm)
      end)
    end)
    |> Enum.map(fn {k, v} -> {k, v.count} end)
    |> Enum.sort_by(fn {_, v} -> v end, :desc)
    |> Enum.take(2)
    |> Enum.reduce(1, fn {_, v}, acc -> v * acc end)
  end
end
