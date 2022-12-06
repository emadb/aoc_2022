defmodule Aoc.Day06Test do
  use ExUnit.Case
  @test_input "./test/inputs/day_06.txt"
  @real_input "./lib/inputs/day_06.txt"

  test "part one (test)" do
    input = Path.absname(@test_input)
    result = Aoc.Day06.part_one(input)

    assert result == 7
  end

  test "part one" do
    input = Path.absname(@real_input)
    result = Aoc.Day06.part_one(input)
    assert result == 1566
  end

  test "part two (test)" do
    input = Path.absname(@test_input)
    result = Aoc.Day06.part_two(input)

    assert result == 19
  end

  test "part two" do
    input = Path.absname(@real_input)
    result = Aoc.Day06.part_two(input)
    assert result == 2265
  end

end
