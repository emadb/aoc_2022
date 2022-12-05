defmodule Aoc.Day05Test do
  use ExUnit.Case
  @test_input "./test/inputs/day_05.txt"
  @real_input "./lib/inputs/day_05.txt"

  test "part one (test)" do
    input = Path.absname(@test_input)
    result = Aoc.Day05.part_one(input)

    assert result == "CMZ"
  end

  test "part one" do
    input = Path.absname(@real_input)
    result = Aoc.Day05.part_one(input)
    assert result == "TLFGBZHCN"
  end

  test "part two (test)" do
    input = Path.absname(@test_input)
    result = Aoc.Day05.part_two(input)

    assert result == "MCD"
  end

  test "part two" do
    input = Path.absname(@real_input)
    result = Aoc.Day05.part_two(input)
    assert result == "QRQFHFWCL"
  end

end
