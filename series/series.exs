defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size) do
    if size > String.length(s) or size <= 0 do
      []
    else
      cursor = size - 1 # account for the zero index
      slice(s, 0, cursor, String.length(s), [])
    end
  end

  defp slice(_s, _pos, cursor, length, substrings) when cursor == length do
    substrings
  end

  defp slice(s, pos, cursor, length, substrings) do
    substrings = substrings ++ [String.slice(s, pos..cursor)]
    slice(s, pos + 1, cursor + 1, length, substrings)
  end

end
