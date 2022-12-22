defmodule Aoc.Day18Test do
  use ExUnit.Case
  @test_input "./test/inputs/day_18.txt"
  @real_input "./lib/inputs/day_18.txt"

  test "part one (test)" do
    input = Path.absname(@test_input)
    result = Aoc.Day18.part_one(input)

    assert result == 64
  end

  test "part one" do
    input = Path.absname(@real_input)
    result = Aoc.Day18.part_one(input)
    assert result == 4332
  end

  test "part two (test)" do
    input = Path.absname(@test_input)
    result = Aoc.Day18.part_two(input)

    assert result == 58
  end

  test "part two" do
    input = Path.absname(@real_input)
    result = Aoc.Day18.part_two(input)
    assert result == nil
  end

end
