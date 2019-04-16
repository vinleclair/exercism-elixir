defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.
  """
  @spec parse(String.t()) :: String.t()
  def parse(markdown_string) do
    markdown_string
    |> String.split("\n")
    |> Enum.map_join(fn
        "#"   <>  line -> process_header(line, 1)
        "* "  <>  line -> "<li>#{line}</li>"
                  line -> "<p>#{line}</p>"
    end)
    |> replace_markdown
  end

  defp process_header(" " <> line, acc),  do: "<h#{acc}>#{line}</h#{acc}>"
  defp process_header("#" <> line, acc),  do: process_header(line, acc + 1)
  
  defp replace_markdown(line) do 
    line
    |> String.replace(~r/<li>.*<\/li>/, "<ul>\\0</ul>")
    |> String.replace(~r/__(.*)__/, "<strong>\\1</strong>")
    |> String.replace(~r/_(.*)_/, "<em>\\1</em>")
  end
end

