defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    total = Enum.reduce(Integer.digits(number), 0, fn digit, acc -> acc + :math.pow(digit, number |> Integer.digits() |> length()) |> trunc() end)
    if total == number, do: true, else: false
  end
end
