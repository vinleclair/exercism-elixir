defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
    with sentence <- sentence |> String.downcase |> to_charlist do
      do_pangram?(sentence, Enum.to_list(?a..?z))
    end
  end

  defp do_pangram?(_, []), do: true
  defp do_pangram?([], _), do: false
  defp do_pangram?([h|t], alphabet), do: do_pangram?(t, List.delete(alphabet, h))
end
