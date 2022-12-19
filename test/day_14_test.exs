defmodule Aoc.Day14Test do
  use ExUnit.Case
  @test_input "./test/inputs/day_14.txt"
  @real_input "./lib/inputs/day_14.txt"

  test "part one (test)" do
    input = Path.absname(@test_input)
    result = Aoc.Day14.part_one(input)

    assert result == 24
  end

  test "part one" do
    input = Path.absname(@real_input)
    result = Aoc.Day14.part_one(input)
    assert result == 843
  end

  test "part two (test)" do
    input = Path.absname(@test_input)
    result = Aoc.Day14.part_two(input)

    assert result == 93
  end

  test "part two" do
    input = Path.absname(@real_input)
    result = Aoc.Day14.part_two(input)
    assert result == 27625
  end

end
