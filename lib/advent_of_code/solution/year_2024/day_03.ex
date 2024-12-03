defmodule AdventOfCode.Solution.Year2024.Day03 do
  @spec part1(String.t()) :: integer()
  def part1(input) do
    Regex.scan(~r/mul\((\d+),(\d+)\)/, input, capture: :all_but_first)
    |> Enum.reduce(0, fn [l, r], acc -> acc + String.to_integer(l) * String.to_integer(r) end)
  end

  def part2(input) do
    Regex.scan(~r/(do)\(\)|(don't)\(\)|mul\((\d+),(\d+)\)/, input, capture: :all_but_first)
    |> Enum.reduce({:do, 0}, fn match, {state, sum} ->
      case {match, state} do
        {["do"], _} ->
          {:do, sum}
        {[_, "don't"], _} ->
          {:dont, sum}
        {[_, _, l, r], :do} ->
          {state, sum + String.to_integer(l) * String.to_integer(r)}
        _ ->
          {state, sum}
      end
    end)
    |> elem(1)
  end
end
