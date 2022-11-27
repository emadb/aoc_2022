defmodule Aoc.Day1Test do
  use ExUnit.Case
  @day 1
  @test_input "./test/test_inputs/day_#{@day}.txt"
  @real_input "./lib/inputs/day_#{@day}.txt"

  test "part one (test)" do
    input = Path.absname(@test_input)
    result = Aoc.Day1.part_one(input)

    assert result == 42
  end

  test "part one" do
    input = Path.absname(@real_input)
    result = Aoc.Day1.part_one(input)
    assert result == 42
  end

end
