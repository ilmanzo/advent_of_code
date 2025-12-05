# To run these tests, navigate to this directory in your terminal and execute:
# elixir day05_test.exs

ExUnit.start()

# Load the code from the script we want to test.
# This assumes you run the test from the same directory as day05.exs.
Code.require_file("day05.exs")

defmodule Day05Test do
  use ExUnit.Case, async: true

  describe "part1/2" do
    test "with data from sample.txt" do
      fresh = [3..5, 10..14, 16..20, 12..18]
      ingredients = [1, 5, 8, 11, 17, 32]
      assert Day05.part1(fresh, ingredients) == 3
    end
  end

  describe "part2/1" do
    test "with data from sample.txt" do
      fresh = [3..5, 10..14, 16..20, 12..18]
      # merges to [3..5, 10..20], sizes 3 + 11 = 14
      assert Day05.part2(fresh) == 14
    end
  end
end
