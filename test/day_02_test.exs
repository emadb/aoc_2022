defmodule Aoc.Day02Test do
  use ExUnit.Case
  @test_input "./test/inputs/day_02.txt"
  @real_input "./lib/inputs/day_02.txt"

  test "part one (test)" do
    input = Path.absname(@test_input)
    result = Aoc.Day02.part_one(input)

    assert result == 15
  end

  test "part one" do
    input = Path.absname(@real_input)
    result = Aoc.Day02.part_one(input)
    assert result == 14297
  end

  test "part two (test)" do
    input = Path.absname(@test_input)
    result = Aoc.Day02.part_two(input)

    assert result == 12
  end

  test "part two" do
    input = Path.absname(@real_input)
    result = Aoc.Day02.part_two(input)
    assert result == 10498
  end

end
