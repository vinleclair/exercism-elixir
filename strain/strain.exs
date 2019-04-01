defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    # Enum.filter(list,fun)
    Enum.reduce(list, [], fn (i, acc) -> if fun.(i), do: acc ++ [i], else: acc end)
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    # Enum.reject(list,fun)
    Enum.reduce(list, [], fn (i, acc) -> if !fun.(i), do: acc ++ [i], else: acc end)
  end
end

