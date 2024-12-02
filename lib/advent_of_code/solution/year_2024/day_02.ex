defmodule AdventOfCode.Solution.Year2024.Day02 do
  use AdventOfCode.Solution.SharedParse

  defp is_safe?(report, dampener \\ false) do
    chunked =
      Enum.with_index(report)
      |> Enum.chunk_every(2, 1, :discard)

    # make an assumption about direction
    [{a, _}, {b, _}] = Enum.at(chunked, 0)
    is_ascending = a < b

    bad_idxs =
      Enum.reduce(chunked, MapSet.new(), fn [{a, idx_a}, {b, idx_b}], bad_idxs ->
        if a == b or is_ascending != a < b or abs(a - b) > 3 do
          MapSet.put(bad_idxs, idx_a)
          |> MapSet.put(idx_b)
        else
          bad_idxs
        end
      end)

    if Enum.count(bad_idxs) > 0 and dampener do
      # we add the first index to check if our ordering assumption
      # was incorrect
      Enum.any?(MapSet.put(bad_idxs, 0), fn idx ->
        is_safe?(List.delete_at(report, idx))
      end)
    else
      Enum.count(bad_idxs) == 0
    end
  end

  @spec parse(binary()) :: list(list(integer()))
  def parse(input) do
    String.split(input, "\n", trim: true)
    |> Enum.map(fn line -> String.split(line, " ") |> Enum.map(&String.to_integer/1) end)
  end

  @spec part2(list(list(integer()))) :: non_neg_integer()
  def part1(input) do
    Enum.count(input, &is_safe?/1)
  end

  @spec part2(list(list(integer()))) :: non_neg_integer()
  def part2(input) do
    Enum.count(input, (& is_safe?(&1, true)))
  end
end
