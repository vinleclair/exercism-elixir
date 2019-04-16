defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    str
    |> String.replace(~r/[^\(\)\[\]\{\}]/, "")
    |> do_check_brackets()
  end

  defp do_check_brackets(""), do: true
  defp do_check_brackets(str) do
    stripped = String.replace(str, ~r/\(\)|\[\]|\{\}/, "")

    if String.length(stripped) != String.length(str), do: do_check_brackets(stripped), else: false
  end
end
