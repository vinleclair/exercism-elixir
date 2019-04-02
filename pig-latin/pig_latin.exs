defmodule PigLatin do
  @vowels ["a", "e", "i", "o", "u"]
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split
    |> Enum.map(&translate_word(&1))
    |> Enum.join(" ")
  end

  defp translate_word(word) do
    if is_vowel_group(word) do
      word <> "ay"
    else
      [start, rest] = split_word(word)
      rest <> start <> "ay"
    end
  end

  defp is_vowel_group(word) do
    cond do
      String.starts_with?(word, @vowels) ->
        true
      Regex.match?(~r/([x-y][^aeiou].*)/, word) ->
          true
      true ->
          false
    end
  end

  defp split_word(word) do
    String.split(word, ~r{[aeiou].*|([a-z]?qu)}, parts: 2, include_captures: true, trim: true)
  end
end
