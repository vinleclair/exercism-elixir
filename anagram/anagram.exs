defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    Enum.filter(candidates, fn candidate -> 
      if String.downcase(candidate) != String.downcase(base) do 
        sort(candidate) == sort(base)
      end
    end)
  end

  defp sort(string) do
    string
    |> String.downcase
    |> String.graphemes
    |> Enum.sort
  end
end
