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

    starting_point = [
      %{h: {0, 0}, t: {0, 0}, moves: []},
      %{h: {0, 0}, t: {0, 0}, moves: []},
      %{h: {0, 0}, t: {0, 0}, moves: []},
      %{h: {0, 0}, t: {0, 0}, moves: []},
      %{h: {0, 0}, t: {0, 0}, moves: []},
      %{h: {0, 0}, t: {0, 0}, moves: []},
      %{h: {0, 0}, t: {0, 0}, moves: []},
      %{h: {0, 0}, t: {0, 0}, moves: []},
      %{h: {0, 0}, t: {0, 0}, moves: []},
      %{h: {0, 0}, t: {0, 0}, moves: []},
    ]

    final_state = Enum.reduce(cmd, starting_point, fn d, states ->
      move2(d, states)
    end)

    fs = List.last(final_state)
    moves = Enum.uniq(fs.moves)
    |> Enum.count()
    moves + 1
  end

  defp move2({_, 0}, states), do: states
  defp move2({d, n}, states) do
    {new_states, _} = Enum.reduce(states, {[], nil}, fn s, {news, prev_tail} ->
      case prev_tail do
        nil ->
          new_h = move_head(d, s.h)
          new_state = move_tail(d, %{s | h: new_h})
          {news ++ [new_state], new_state.t}
        _ ->
          # new_h = move_head(d, s.h)
          new_state = move_tail(d, %{s | h: prev_tail})
          {news ++ [new_state], new_state.t}
      end
    end)
    move2({d, n - 1}, new_states)
  end

end
