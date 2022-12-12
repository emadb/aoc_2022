defmodule Aoc.Day11Test do
  use ExUnit.Case
  @test_input "./test/inputs/day_11.txt"
  @real_input "./lib/inputs/day_11.txt"

  test "part one (test)" do
    result = Aoc.Day11.part_one(part1_test_data())

    assert result == 10605
  end

  test "part one" do
    result = Aoc.Day11.part_one(part1_real_data())
    assert result == 111210
  end

  @tag timeout: :infinity
  test "part two (test)" do
    result = Aoc.Day11.part_two(part1_test_data())
    assert result == 2713310158
  end

  test "part two" do
    result = Aoc.Day11.part_two(part1_real_data())
    assert result == 15447387620
  end


  def part1_test_data() do
    %{
      0 => %{
        count: 0,
        items: [79, 98],
        op: fn old -> Integer.mod(old * 19, 96577) end,
        test: fn d -> if rem(d, 23) == 0, do: 2, else: 3 end,
        throw_to: []
      },
      1 => %{
        count: 0,
        items: [54, 65, 75, 74],
        op: fn old -> old + 6 end,
        test: fn d -> if rem(d, 19) == 0, do: 2, else: 0 end,
        throw_to: []
      },
      2 => %{
        count: 0,
        items: [79, 60, 97],
        op: fn old -> Integer.mod(old * old, 96577) end,
        test: fn d -> if rem(d, 13) == 0, do: 1, else: 3 end,
        throw_to: []
      },
      3 => %{
        count: 0,
        items: [74],
        op: fn old -> old + 3 end,
        test: fn d -> if rem(d, 17) == 0, do: 0, else: 1 end,
        throw_to: []
      }
    }
  end

  def part1_real_data() do
    %{
      0 => %{
        count: 0,
        items: [54, 53],
        op: fn old -> Integer.mod(old * 3, 9699690) end,
        test: fn d -> if rem(d, 2) == 0, do: 2, else: 6 end,
        throw_to: []
      },
      1 => %{
        count: 0,
        items: [95, 88, 75, 81, 91, 67, 65, 84],
        op: fn old -> Integer.mod(old * 11, 9699690) end,
        test: fn d -> if rem(d, 7) == 0, do: 3, else: 4 end,
        throw_to: []
      },
      2 => %{
        count: 0,
        items: [76, 81, 50, 93, 96, 81, 83],
        op: fn old -> old + 6 end,
        test: fn d -> if rem(d, 3) == 0, do: 5, else: 1 end,
        throw_to: []
      },
      3 => %{
        count: 0,
        items: [83, 85, 85, 63],
        op: fn old -> old + 4 end,
        test: fn d -> if rem(d, 11) == 0, do: 7, else: 4 end,
        throw_to: []
      },
      4 => %{
        count: 0,
        items: [85, 52, 64],
        op: fn old -> old + 8 end,
        test: fn d -> if rem(d, 17) == 0, do: 0, else: 7 end,
        throw_to: []
      },
      5 => %{
        count: 0,
        items: [57],
        op: fn old -> old + 2 end,
        test: fn d -> if rem(d, 5) == 0, do: 1, else: 3 end,
        throw_to: []
      },
      6 => %{
        count: 0,
        items: [60, 95, 76, 66, 91],
        op: fn old -> Integer.mod(old * old, 9699690) end,
        test: fn d -> if rem(d, 13) == 0, do: 2, else: 5 end,
        throw_to: []
      },
      7 => %{
        count: 0,
        items: [65, 84, 76, 72, 79, 65],
        op: fn old -> old + 5 end,
        test: fn d -> if rem(d, 19) == 0, do: 6, else: 0 end,
        throw_to: []
      }
    }
    end
end
