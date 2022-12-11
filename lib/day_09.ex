defmodule Aoc.Day09 do
  def part_one(input) do
    cmd = input
    |> InputReader.get_lines_string()
    |> Enum.map(fn l ->
      [dir, n] = String.split(l, " ")
      {dir, String.to_integer(n)}
    end)

    starting_point = %{h: {0, 0}, t: {0, 0}, moves: []}

    final_state = Enum.reduce(cmd, starting_point, fn cmd, state -> move(cmd, state) end)
    moves = Enum.uniq(final_state.moves) |> Enum.count()
    moves + 1
  end

  defp move({_, 0}, state), do: state
  defp move({d, n}, state) do
    new_h = move_head(d, state.h)
    new_state = move_tail(d, %{state | h: new_h})
    move({d, n - 1}, new_state)
  end

  defp move_head("R", {x, y}), do: {x + 1, y}
  defp move_head("L", {x, y}), do: {x - 1, y}
  defp move_head("D", {x, y}), do: {x, y - 1}
  defp move_head("U", {x, y}), do: {x, y + 1}

  def move_tail("R", state) do
    {_xh, yh} = state.h
    {xt, _yt} = state.t
    if neighbord?(state.h, state.t) do
      state
    else
     %{state | t: {xt + 1, yh}, moves: state.moves ++ [{xt + 1, yh}]}
    end
  end
  def move_tail("L", state) do
    {_xh, yh} = state.h
    {xt, _yt} = state.t
    if neighbord?(state.h, state.t) do
      state
    else
     %{state | t: {xt - 1, yh}, moves: state.moves ++ [{xt - 1, yh}]}
    end
  end
  def move_tail("U", state) do
    {xh, _yh} = state.h
    {_xt, yt} = state.t
    if neighbord?(state.h, state.t) do
      state
    else
     %{state | t: {xh, yt + 1}, moves: state.moves ++ [{xh, yt + 1}]}
    end
  end
  def move_tail("D", state) do
    {xh, _yh} = state.h
    {_xt, yt} = state.t
    if neighbord?(state.h, state.t) do
      state
    else
      %{state | t: {xh, yt - 1}, moves: state.moves ++ [{xh, yt - 1}]}
    end
  end

  def neighbord?({xh, yh}, {xt, yt}) do
    Enum.member?([
      {xh - 1, yh - 1},
      {xh - 1, yh},
      {xh - 1, yh + 1},
      {xh, yh},
      {xh, yh - 1},
      {xh, yh + 1},
      {xh + 1, yh - 1},
      {xh + 1, yh},
      {xh + 1, yh + 1}], {xt, yt})
  end

  def part_two(input) do
    cmd = input
    |> InputReader.get_lines_string()
    |> Enum.map(fn l ->
      [dir, n] = String.split(l, " ")
      {dir, String.to_integer(n)}
    end)

    starting_point = %{
      h1: {0, 0},
      h2: {0, 0},
      h3: {0, 0},
      h4: {0, 0},
      h5: {0, 0},
      h6: {0, 0},
      h7: {0, 0},
      h8: {0, 0},
      h9: {0, 0},
      h0: {0, 0},
      moves: []}

      final_state = Enum.reduce(cmd, starting_point, fn cmd, state -> move2(cmd, state) end)

      IO.inspect final_state, label: "FINAL"
      moves = Enum.uniq(final_state.moves) |> Enum.count()
      moves + 1
  end

  defp move2({d, 0}, state) do
    IO.inspect state, label: "DIRECTION #{d}"
    state
  end
  defp move2({d, n}, state) do
    new_h = move_head(d, state.h1)
    IO.inspect new_h, label: d # {4, 1}
    new_state = move_hn(%{state | h1: new_h}, d, :h1, :h2)
    |> move_hn(d, :h2, :h3)
    |> move_hn(d, :h3, :h4)
    |> move_hn(d, :h4, :h5)
    |> move_hn(d, :h5, :h6)
    |> move_hn(d, :h6, :h7)
    |> move_hn(d, :h7, :h8)
    |> move_hn(d, :h8, :h9)
    |> move_hn(d, :h9, :h0)

    move2({d, n - 1}, new_state)
  end

  def move_hn(state, d, h, t) do
    {xh, yh} = state[h]
    {xt, yt} = state[t]

    if neighbord?(state[h], state[t]) do
      state
    else
      new_pos = case d do
        "R" -> {xt + 1, yt}
        "L" -> {xt - 1, yt}
        "U" -> {xt, yt + 1}
        "D" -> {xt, yt - 1}
      end
     if t == :h0 do
      Map.put(%{state | moves: state.moves ++ [new_pos]}, t, new_pos)
     else
      Map.put(state, t, new_pos)
     end
    end
  end

end
