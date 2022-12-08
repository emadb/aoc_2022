defmodule Aoc.Day08Test do
  use ExUnit.Case
  @test_input "./test/inputs/day_08.txt"
  @real_input "./lib/inputs/day_08.txt"

  test "part one (test)" do
    input = Path.absname(@test_input)
    result = Aoc.Day08.part_one(input)

    assert result == 21
  end

  test "part one" do
    input = Path.absname(@real_input)
    result = Aoc.Day08.part_one(input)
    assert result == 1703
  end

  test "part two (test)" do
    input = Path.absname(@test_input)
    result = Aoc.Day08.part_two(input)

    assert result == 8
  end

  test "part two" do
    input = Path.absname(@real_input)
    result = Aoc.Day08.part_two(input)
    assert result == 496650
  end

end
