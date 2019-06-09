defmodule Garden do
  @default_names [:alice, :bob, :charlie, :david, :eve, :fred, :ginny, :harriet, :ileana, :joseph, :kincaid, :larry]
  @plants %{ ?C => :clover, ?G => :grass, ?R => :radishes, ?V => :violets }

  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @default_names) do
    [ row1, row2 ] = String.split(info_string)
    _info(row1, row2, Enum.sort(student_names))
  end

  defp _info(<<p1::utf8,p2::utf8>> <> row1, <<p3::utf8,p4::utf8>> <> row2, [name|names]), do:
    Map.put(_info(row1, row2, names), name, { @plants[p1], @plants[p2], @plants[p3], @plants[p4] })

  defp _info(_, _, [name|names]), do:
    Map.put(_info("", "", names), name, {})

  defp _info(_, _, []), do:
    %{}
end
