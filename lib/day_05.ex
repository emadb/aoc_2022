defmodule Aoc.Day05 do
  def part_one(input) do
    [stacks, instructions] = input
    |> File.read!()
    |> String.split("\n\n")

    stacks = build_stack(stacks)
    instructions = parse_instructions(instructions)

    operate(stacks, instructions)
    |> Enum.map(fn s ->
      {e, _} = Stack.pop(s)
      e
    end)
    |> Enum.join()
  end

  def part_two(input) do
    [stacks, instructions] = input
    |> File.read!()
    |> String.split("\n\n")

    stacks = build_stack(stacks)
    instructions = parse_instructions(instructions)

    operate_9001(stacks, instructions)
    |> Enum.map(fn s ->
      {e, _} = Stack.pop(s)
      e
    end)
    |> Enum.join()
  end

  defp operate(stacks, instructions) do

    Enum.reduce(instructions, stacks, fn [n, from, to], s ->
        stack_from = Enum.at(s, from)
        stack_to = Enum.at(s, to)

        {stack_from, stack_to} = Enum.reduce(1..n, {stack_from, stack_to}, fn _, {sf, st} ->
          {head, sf} = Stack.pop(sf)
          st = Stack.push(st, head)
          {sf, st}
        end)

        s
        |> List.replace_at(from, stack_from)
        |> List.replace_at(to, stack_to)
    end)

  end

  defp operate_9001(stacks, instructions) do

    Enum.reduce(instructions, stacks, fn [n, from, to], s ->
      stack_from = Enum.at(s, from)
      stack_to = Enum.at(s, to)

      {head, sf} = MultiStack.pop(stack_from, n)
      st = MultiStack.push(stack_to, head)

      s
      |> List.replace_at(from, sf)
      |> List.replace_at(to, st)
    end)

  end

  defp parse_instructions(instructions) do
    instructions
    |> String.split("\n")
    |> Enum.map(fn i ->
      [_, n, _, from, _, to] = String.split(i, " ")
      [String.to_integer(n), String.to_integer(from) - 1, String.to_integer(to) - 1]
    end)
  end


  defp build_stack(stacks) do
    lines = String.split(stacks, "\n")
    [header | stacks] = Enum.reverse(lines)

    parsed_stack = Enum.map(stacks, fn s ->
      Enum.map(Regex.scan(~r/(?:(\s{3})|\[([A-Z])\])\s?/, s),
        fn [_, _, l] -> l
           [_, _] -> " "
        end)
    end)
    stacks_count = String.split(header, "   ") |> Enum.count()
    working_stacks = 1..stacks_count |> Enum.map(fn _ -> Stack.new() end)

    Enum.reduce(parsed_stack, working_stacks, fn row, ws ->
      Enum.zip_with(row, ws,
      fn " ", w -> w
         r, w -> Stack.push(w, r)  end)
    end)
  end
end

defmodule Stack do
  def new(), do: []
  def push(stack, item), do: [item | stack]
  def pop([head | stack]), do: {head, stack}
end

defmodule MultiStack do
  def new(), do: []
  def push(stack, items) do
    items ++ stack
  end
  def pop(stack, n) do
    head = Enum.take(stack, n)
    {head, stack -- head}
  end
end
