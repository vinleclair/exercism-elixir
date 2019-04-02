defmodule Bob do
  def hey(input) do
    cond do
      Regex.match?(~r/([\p{Lu}]{2,})/, input) and String.ends_with?(input, "?") ->
        "Calm down, I know what I'm doing!"
      String.ends_with?(input, "?") ->
        "Sure."
      String.split(input) == [] ->
        "Fine. Be that way!"
      Regex.match?(~r/([\p{L}])/, input) and String.upcase(input) == input ->
        "Whoa, chill out!"
      true ->
        "Whatever."
    end
  end
end
