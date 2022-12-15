defmodule Aoc.Day13 do
  def part_one(input) do
    input
    |> InputReader.get_lines_string()
    |> Enum.reject(fn l -> l == "" end)
    |> Enum.chunk_every(2)
    |> Enum.with_index(1)
    |> Enum.map(fn {[a, b], i} ->
       check_packet(a, b, i)
     end)
     |> Enum.sum()
  end

  defp check_packet(a, b, index) do
    {part_1,_} = Code.eval_string(a)
    {part_2,_} = Code.eval_string(b)
    if eval(part_1, part_2), do: index, else: 0
  end


  def eval(a, b) when is_integer(a) and is_integer(b) do
    cond do
      a < b -> true
      a > b -> false
      a == b -> :continue
    end
  end

  def eval([a | resta], [b | restb]) do
    r = eval(a, b)
    if is_boolean(r), do: r, else: eval(resta, restb)
  end
  def eval([], [_ | _]), do: true
  def eval([_ | _], []), do: false
  def eval([], []), do: :continue
  def eval(a, b) when is_list(a) and is_integer(b), do: eval(a, [b])
  def eval(a, b) when is_integer(a) and is_list(b), do: eval([a], b)

  def part_two(input) do
    input
    |> InputReader.get_lines_string()
    |> Enum.reject(fn l -> l == "" end)
    |> Enum.concat(["[[2]]"])
    |> Enum.concat(["[[6]]"])
    |> Enum.map(fn l ->
      {e, _} = Code.eval_string(l)
      e
    end)
    |> IO.inspect(label: "lines")
    |> Enum.sort(fn a, b ->
       eval(a, b)
     end)
    |> find_dividers()
  end

  defp find_dividers(list) do
    d2 = Enum.find_index(list, fn x -> x == [[2]] end) + 1
    d6 = Enum.find_index(list, fn x -> x == [[6]] end) + 1
    d2 * d6
  end
end
