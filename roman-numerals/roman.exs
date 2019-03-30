defmodule Roman do
  @ones %{1 => "I", 2 => "II", 3 => "III", 4 => "IV", 5 => "V", 6 => "VI", 7 => "VII", 8 => "VIII", 9 => "IX", 0 => ""}
  @tens %{1 => "X", 2 => "XX", 3 => "XXX", 4 => "XL", 5 => "L", 6 => "LX", 7 => "LXX", 8 => "LXXX", 9 => "XC", 0 => ""}
  @hundreds %{1 => "C", 2 => "CC", 3 => "CCC", 4 => "CD", 5 => "D", 6 => "DC", 7 => "DCC", 8 => "DCCC", 9 => "CM", 0 => ""}
  @thousands %{1 => "M", 2 => "MM", 3 => "MMM"}

  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t()
  def numerals(number) do
    number
    |> Integer.digits() 
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.reverse()
    |> Enum.reduce("", fn {k, v}, acc -> acc <> Map.get(convert(v), k) end)
  end

  def convert(pos) when pos == 0, do: @ones
  def convert(pos) when pos == 1, do: @tens
  def convert(pos) when pos == 2, do: @hundreds
  def convert(pos) when pos == 3, do: @thousands

end

IO.inspect Roman.numerals(1)
IO.inspect Roman.numerals(2)
IO.inspect Roman.numerals(21)
