defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def square(number) when number < 1 or number > 64, 
    do: {:error, "The requested square must be between 1 and 64 (inclusive)"}
  def square(number), do: {:ok, do_square(number)} 
  defp do_square(number), do: :math.pow(2, number - 1) |> round

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total, do: {:ok, do_total} 
  defp do_total, do: Enum.reduce(1..64, fn n, acc -> acc + do_square(n) end)
end
