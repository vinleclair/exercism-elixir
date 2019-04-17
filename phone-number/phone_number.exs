defmodule Phone do
  @invalid_number "0000000000"

  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)
  """
  @spec number(String.t()) :: String.t()
  def number(raw) do 
    raw
    |> String.replace(~r/([^\w])/, "")
    |> slice_area_code
    |> check_validity 
  end

  defp slice_area_code(number) do 
    if String.length(number) == 11 and String.first(number) == "1" do 
      String.slice(number, 1..11) 
    else
      number
    end
  end
  
  defp check_validity(number) do
    cond do
      Regex.match?(~r/[a-zA-Z]/, number) ->
        @invalid_number
      String.first(number) == "0" or String.first(number) == "1" ->
        @invalid_number
      String.at(number, 3) == "0" or String.at(number, 3) == "1" ->
        @invalid_number
      String.length(number) != 10 ->
        @invalid_number
      true ->
        number
    end
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator
  """
  @spec area_code(String.t()) :: String.t()
  def area_code(raw), do: raw |> number |> String.slice(0..2)

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.
  """
  @spec pretty(String.t()) :: String.t()
  def pretty(raw) do
    number = number(raw)
    "(#{area_code(number)}) #{String.slice(number, 3..5)}-#{String.slice(number, 6..9)}"
  end
end
