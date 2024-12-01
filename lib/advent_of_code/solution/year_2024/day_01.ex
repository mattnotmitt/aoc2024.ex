defmodule AdventOfCode.Solution.Year2024.Day01 do
  use AdventOfCode.Solution.SharedParse

  @spec parse(String.t()) :: {list(integer()), list(integer())}
  def parse(input) do
    list =
      String.split(input, "\n", trim: true)
      |> Enum.flat_map(fn line -> String.split(line, "   ") end)
      |> Enum.map(&String.to_integer/1)

    {
      Enum.take_every(list, 2)
      |> Enum.sort(),
      Enum.slice(list, 1..-1//1)
      |> Enum.take_every(2)
      |> Enum.sort()
    }
  end

  @spec part1({list(integer()), list(integer())}) :: integer()
  def part1({left, right}) do
    Enum.zip_reduce(left, right, 0, fn a, b, acc -> acc + abs(a - b) end)
  end

  @spec part2({list(integer()), list(integer())}) :: integer()
  def part2({left, right}) do
    right_freq = Enum.frequencies(right)

    Enum.reduce(left, 0, fn val, acc -> acc + val * Map.get(right_freq, val, 0) end)
  end
end
