defmodule Aoc.Day07 do

  def part_one(input) do
    parse(input)
    |> Map.to_list()
    |> Enum.map(fn {_, size} -> size end)
    |> Enum.reject(fn size -> size >= 100_000 end)
    |> Enum.sum()
  end

  def part_two(input) do
    source = parse(input)
    space_taken_up = Map.get(source, ["/"])
    free_space = 70_000_000 - space_taken_up
    space_to_free_up = 30_000_000 - free_space

    source
    |> Map.to_list()
    |> Enum.map(&elem(&1, 1))
    |> Enum.filter(fn size -> size > space_to_free_up end)
    |> Enum.sort(:asc)
    |> hd()
  end

  defp parse(input) do
    File.read!(input)
    |> String.trim()
    |> String.split("\n")
    |> parse_command(%{}, [])
    |> Map.to_list()
    |> flat_tree()
  end

  def parse_command([], tree, _), do: tree
  def parse_command([head | tail], tree, pwd) do
    case head do
      "$ cd /" -> parse_command(tail, tree, ["/"])
      "$ cd .." -> parse_command(tail, tree, tl(pwd))
      "$ cd " <> dir -> parse_command(tail, tree, [dir | pwd])
      "$ ls" -> parse_ls(tail, tree, pwd)
    end
  end

  def parse_ls([], tree, pwd), do: parse_command([], tree, pwd)
  def parse_ls([head | tail], tree, pwd) do
    case head do
      "$" <> _ -> parse_command([head | tail], tree, pwd)
      "dir " <> _dir -> parse_ls(tail, tree, pwd)
      size_name ->
        [size, filename] = String.split(size_name, " ")
        tuple = {filename, String.to_integer(size)}
        new_tree = tree |> Map.update(pwd, [tuple], fn existing -> [tuple | existing] end)
        parse_ls(tail, new_tree, pwd)
    end
  end

  def flat_tree(tree, flat \\ %{})
  def flat_tree([], flat), do: flat
  def flat_tree([head | tail], flat) do
    {path, files} = head
    total_size = files |> Enum.map(fn {_, size} -> size end) |> Enum.sum()
    new_flat = groups(path) |> Enum.reduce(flat, fn path, flat ->
      Map.update(flat, path, total_size, &(&1 + total_size))
    end)
    flat_tree(tail, new_flat)
  end

  def groups([one]), do: [[one]]
  def groups([_head | tail] = list), do: [list | groups(tail)]
end
