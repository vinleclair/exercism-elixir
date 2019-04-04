defmodule Bob do
  def hey(input) do
    cond do
      question?(input) and uppercase_letters?(input) ->
        "Calm down, I know what I'm doing!"

      question?(input) ->
        "Sure."

      uppercase_letters?(input) ->
        "Whoa, chill out!"

      empty?(input) ->
        "Fine. Be that way!"

      true ->
        "Whatever."
    end
  end

  defp question?(string), do: String.ends_with?(string, "?")

  defp uppercase_letters?(string), 
    do: String.upcase(string) != String.downcase(string) and String.upcase(string) == string 

  defp empty?(string), do: String.trim(string) == ""

end

