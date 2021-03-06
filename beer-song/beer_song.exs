defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(number),
    do: """
  #{number |> bottles |> String.capitalize} of beer on the wall, #{number |> bottles} of beer.
  #{number |> action}, #{number - 1 |> bottles} of beer on the wall.
  """

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range \\ 99..0) do 
    Enum.map_join(range, "\n", &verse(&1))
  end

  defp bottles(0), do: "no more bottles"
  defp bottles(1), do: "1 bottle"
  defp bottles(n), do: "#{if n > 0, do: n, else: 99} bottles"

  defp action(0), do: "Go to the store and buy some more"
  defp action(n), do: "Take #{if n == 1, do: "it", else: "one"} down and pass it around"
end
