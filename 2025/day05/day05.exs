defmodule Day05 do

  @doc """
  For each ingredient, counts if it is present in any of the fresh ranges.
  """
  def part1(fresh, ingredients) do
    Enum.count(ingredients, fn ingredient ->
      Enum.any?(fresh, &(ingredient in &1))
    end)
  end

  @doc """
  Sorts and merges overlapping/adjacent ranges, then sums their sizes.
  """
  def part2(fresh) do
        fresh
        |> Enum.sort()
        |> merge_ranges()
        |> Enum.map(&Range.size/1)
        |> Enum.sum()
  end

  @doc """
  Merges a sorted list of overlapping or adjacent ranges using recursion.
  """
  defp merge_ranges([]), do: []

  defp merge_ranges([r1, r2 | rest]) when r2.first <= r1.last + 1 do
    merged_range = r1.first..max(r1.last, r2.last)
    merge_ranges([merged_range | rest])
  end

  defp merge_ranges([head | tail]) do
    [head | merge_ranges(tail)]
  end

  def main(args) do
    # Use command-line argument for file path, or default to "05.txt".
    input_file = List.first(args) || "05.txt"

    with {:ok, file_content} <- File.read(input_file) do
      # Parse the two main sections of the input file.
      [fresh_part, ingredients_part] = String.split(file_content, "\n\n", trim: true)

      # Parse the ranges. Elixir's `..` creates inclusive ranges.
      fresh =
        fresh_part
        |> String.split("\n", trim: true)
        |> Enum.map(fn line ->
          [lower, upper] = String.split(line, "-") |> Enum.map(&String.to_integer/1)
          lower..upper
        end)

      # Parse the ingredients.
      ingredients =
        ingredients_part
        |> String.split("\n", trim: true)
        |> Enum.map(&String.to_integer/1)

      p1 = part1(fresh, ingredients)
      p2 = part2(fresh)
      IO.puts("part1: #{p1}, part2: #{p2}")
    else
      {:error, reason} ->
        IO.puts(:stderr, "Error reading file: #{:file.format_error(reason)}")
    end
  end
end

Day05.main(System.argv())
