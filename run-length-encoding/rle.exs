defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    Regex.scan(~r/(.)\1+|(.)/, string, capture: :first)
    |> Enum.reduce("", fn chars, acc -> acc <> get_data_value(List.first(chars)) end)
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
  end

  defp get_data_value(chars) do
    if String.length(chars) != 1 do
      "#{String.length(chars)}#{String.at(chars, 0)}"
    else
      "#{String.at(chars, 0)}"
    end
  end
end

