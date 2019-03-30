defmodule Roman do
  @roman_numerals [
    {1000, "M"},
    {900, "CM"},
    {500, "D"},
    {400, "CD"},
    {100, "C"},
    {90, "XC"},
    {50, "L"},
    {40, "XL"},
    {10, "X"},
    {9, "IX"},
    {5, "V"},
    {4, "IV"},
    {1, "I"}
  ]

  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t()
  def numerals(number) do
    convert(number, "")
  end

  defp convert(0, result), do: result 

  defp convert(number, result) do
    {arabic, roman} =
      Enum.find(@roman_numerals, fn x -> 
        {arabic, roman} = x
        number - arabic >= 0 
      end)
    convert(number - arabic, result <> roman)
  end
end

IO.inspect Roman.numerals(1)
IO.inspect Roman.numerals(2)
IO.inspect Roman.numerals(21)
