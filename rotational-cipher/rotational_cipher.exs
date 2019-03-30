defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> to_charlist
    |> Enum.map(&shift(&1, shift))
    |> to_string
  end

  defp shift(char, shift) do
    cond do
      char >= ?a and char <= ?z ->
        ?a + rem(char - ?a + shift, 26)
      char >= ?A and char <= ?Z ->
        ?A + rem(char - ?A + shift, 26)
      true ->
        char
    end
  end
end
