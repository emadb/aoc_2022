defmodule Aoc.Day13Test do
  use ExUnit.Case
  @test_input "./test/inputs/day_13.txt"
  @real_input "./lib/inputs/day_13.txt"

  test "part one (test)" do
    input = Path.absname(@test_input)
    result = Aoc.Day13.part_one(input)

    assert result == 13
  end

  test "part one" do
    input = Path.absname(@real_input)
    result = Aoc.Day13.part_one(input)
    assert result == 5675
  end

  test "part two (test)" do
    input = Path.absname(@test_input)
    result = Aoc.Day13.part_two(input)

    assert result == 140
  end

  test "part two" do
    input = Path.absname(@real_input)
    result = Aoc.Day13.part_two(input)
    assert result == nil
  end

end
