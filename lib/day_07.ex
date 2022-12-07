# defmodule Tree do
#   defstruct files: [], parent_id: ""
# end

# defmodule File do
#   defstruct name: "", size: 0
# end

defmodule Aoc.Day07 do

  def part_one(input) do
    list = InputReader.get_lines_string(input)

    {parsed_nodes, _} = Enum.reduce(list, {%{}, nil}, fn cmd, nodes ->
      parse_command(cmd, nodes)
    end)

    node_with_local_total = parsed_nodes
    |> Enum.reduce(parsed_nodes, fn {k, v}, nodes ->
      new_value = Map.put_new(v, :total_size, sum_files(v.files))
      Map.put(nodes, k, new_value)
    end)

    node_with_global_total = node_with_local_total
    |> Enum.reduce(node_with_local_total, fn {k, v}, nodes ->
      new_value = Map.put_new(v, :total_size_with_children, sum_files_with_children(nodes, k))
      Map.put(nodes, k, new_value)
    end)

    node_with_global_total
    |> Enum.filter(fn {_k, v} -> v.total_size_with_children <= 100_000 end)
    |> Enum.map(fn {_, n} -> n.total_size_with_children end)
    |> Enum.sum()

  end

  defp sum_files_with_children(nodes, current) do
    children_keys = Enum.filter(nodes, fn {_k, v} -> v.parent_id == current end) |> Enum.map(fn {k, _} -> k end)

    Enum.reduce(children_keys, nodes[current].total_size, fn k, acc ->
      acc + sum_files_with_children(nodes, k)
    end)
  end

  defp sum_files(files) do
    Enum.reduce(files, 0, fn f, acc -> acc + f.size end)
  end

  defp parse_command("$ cd /", _nodes) do
    {%{"/" => %{files: [], parent_id: nil}}, "/"}
  end

  defp parse_command("$ ls", {nodes, current}) do
    {nodes, current}
  end

  defp parse_command("$ cd " <> folder, {nodes, _current}) do
    {nodes, folder}
  end

  defp parse_command("$ cd ..", {nodes, current}) do
    {new_current, _} = Enum.find(nodes, fn {_k, v} -> v.parent_id == current end)
    {nodes , new_current}
  end

  defp parse_command("dir " <> folder, {nodes, current}) do
    {Map.put(nodes, folder, %{files: [], parent_id: current}) , current}
  end

  defp parse_command(cmd, {nodes, current}) do
    [size, name] = String.split(cmd, " ")
    new_file = %{name: name, size: String.to_integer(size)}

    new_node = Map.update!(nodes, current, fn n ->
      %{files: n.files ++ [new_file], parent_id: n.parent_id}
    end)

    {new_node, current}
  end

  def part_two(input) do
    input
  end
end
