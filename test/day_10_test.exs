defmodule Aoc.Day10Test do
  use ExUnit.Case
  @test_input "./test/inputs/day_10.txt"
  @real_input "./lib/inputs/day_10.txt"

  test "part one (test)" do
    input = Path.absname(@test_input)
    result = Aoc.Day10.part_one(input)

    assert result == 13140
  end

  test "part one" do
    input = Path.absname(@real_input)
    result = Aoc.Day10.part_one(input)
    assert result == 14620
  end

  # test "part two (test)" do
  #   input = Path.absname(@test_input)
  #   result = Aoc.Day10.part_two(input)

  #   IO.inspect result
  # end

  test "part two" do
    input = Path.absname(@real_input)
    result = Aoc.Day10.part_two(input)
    IO.puts "-----"
    IO.puts result
    IO.puts "-----"
  end

end
