defmodule Aoc.Day03Test do
  use ExUnit.Case
  @test_input "./test/inputs/day_03.txt"
  @real_input "./lib/inputs/day_03.txt"

  test "part one (test)" do
    input = Path.absname(@test_input)
    result = Aoc.Day03.part_one(input)

    assert result == 157
  end

  test "part one" do
    input = Path.absname(@real_input)
    result = Aoc.Day03.part_one(input)
    assert result == 7980
  end

  test "part two (test)" do
    input = Path.absname(@test_input)
    result = Aoc.Day03.part_two(input)

    assert result == 70
  end

  test "part two" do
    input = Path.absname(@real_input)
    result = Aoc.Day03.part_two(input)
    assert result == 2881
  end

end
