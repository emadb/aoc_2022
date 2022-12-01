defmodule Aoc.Day01Test do
  use ExUnit.Case
  @test_input "./test/inputs/day_01.txt"
  @real_input "./lib/inputs/day_01.txt"

  test "part one (test)" do
    input = Path.absname(@test_input)
    result = Aoc.Day01.part_one(input)

    assert result == 24000
  end

  test "part one" do
    input = Path.absname(@real_input)
    result = Aoc.Day01.part_one(input)
    assert result == 71023
  end

  test "part two (test)" do
    input = Path.absname(@test_input)
    result = Aoc.Day01.part_two(input)

    assert result == 45000
  end

  test "part two" do
    input = Path.absname(@real_input)
    result = Aoc.Day01.part_two(input)
    assert result == 206289
  end

end
