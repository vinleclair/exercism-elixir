defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(0), do: raise ArgumentError
  def nth(count) do
    Stream.iterate(2, &(&1 + 1))
    |> Stream.filter(&prime?/1)
    |> Enum.take(count)
    |> List.last
  end

  defp prime?(2), do: true
  defp prime?(num) when num < 2 or rem(num, 2) == 0, do: false
  defp prime?(num), do: prime?(num, 3)

  defp prime?(num, factor) when num < factor * factor, do: true
  defp prime?(num, factor) when rem(num, factor) == 0, do: false
  defp prime?(num, factor), do: prime?(num, factor + 2)
end
