defmodule Scrabble do
  @letter_values %{
    ["A", "E", "I", "O", "U", "L", "N", "R", "S", "T"] => 1,
    ["D", "G"] => 2,
    ["B", "C", "M", "P"] => 3,
    ["F", "H", "V", "W", "Y"] => 4,
    ["K"] => 5,
    ["J", "X"] => 8,
    ["Q", "Z"] => 10
  }

  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    word
    |> String.upcase
    |> String.graphemes
    |> Enum.reduce(0, fn letter, acc -> acc + letter_value(letter) end)
  end

  defp letter_value(letter) do 
    Enum.find_value(@letter_values, 0, fn {letters, value} -> if letter in letters, do: value end)
  end
end
