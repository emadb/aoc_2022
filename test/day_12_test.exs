defmodule Aoc.Day12Test do
  use ExUnit.Case
  @test_input "./test/inputs/day_12.txt"
  @real_input "./lib/inputs/day_12.txt"

  test "part one (test)" do
    input = Path.absname(@test_input)
    result = Aoc.Day12.part_one(input)

    assert result == 31
  end

  # test "part one" do
  #   input = Path.absname(@real_input)
  #   result = Aoc.Day12.part_one(input)
  #   assert result == nil
  # end

  # test "part two (test)" do
  #   input = Path.absname(@test_input)
  #   result = Aoc.Day12.part_two(input)

  #   assert result == nil
  # end

  # test "part two" do
  #   input = Path.absname(@real_input)
  #   result = Aoc.Day12.part_two(input)
  #   assert result == nil
  # end

end
