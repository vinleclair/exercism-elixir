defmodule Binary do
  @invalid_binary 0

  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t()) :: non_neg_integer
  def to_decimal(string) do
    if String.match?(string, ~r/^[01]+$/) do
      string
      |> String.to_integer()
      |> Integer.digits()
      |> Enum.reverse()
      |> Enum.with_index()
      |> Enum.reduce(0, fn {digit, index}, acc -> acc + digit * (:math.pow(2, index) |> round) end)
    else
      @invalid_binary
    end
  end
end
