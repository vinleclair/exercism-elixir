defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    factors
    |> Enum.reduce([], fn factor, acc -> 
      for num <- 0..limit - 1, rem(num, factor) == 0, do: acc ++ [num]
    end)
    |> List.flatten 
    |> Enum.uniq
    |> Enum.sum
  end
end
