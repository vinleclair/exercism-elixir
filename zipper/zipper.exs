defmodule BinTree do
  @moduledoc """
  A node in a binary tree.

  `value` is the value of a node.
  `left` is the left subtree (nil if no subtree).
  `right` is the right subtree (nil if no subtree).
  """

  @type t :: %BinTree{value: any, left: t() | nil, right: t() | nil}

  defstruct [:value, :left, :right]
end

defimpl Inspect, for: BinTree do
  import Inspect.Algebra

  # A custom inspect instance purely for the tests, this makes error messages
  # much more readable.
  #
  # BinTree[value: 3, left: BinTree[value: 5, right: BinTree[value: 6]]] becomes (3:(5::(6::)):)
  def inspect(%BinTree{value: value, left: left, right: right}, opts) do
    concat([
      "(",
      to_doc(value, opts),
      ":",
      if(left, do: to_doc(left, opts), else: ""),
      ":",
      if(right, do: to_doc(right, opts), else: ""),
      ")"
    ])
  end
end

defmodule Zipper do
  defstruct [:node, :focus]

  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BinTree.t()) :: Zipper.t()
  def from_tree(bin_tree), do: %__MODULE__{node: bin_tree, focus: []} 

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Zipper.t()) :: BinTree.t()
  def to_tree(%__MODULE__{node: node, focus: []}), do: node
  def to_tree(zipper), do: zipper |> up |> to_tree

  @doc """
  Get the value of the focus node.
  """
  @spec value(Zipper.t()) :: any
  def value(%__MODULE__{node: %BinTree{value: value}}), do: value

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Zipper.t()) :: Zipper.t() | nil
  def left(%__MODULE__{node: %BinTree{left: nil}}), do: nil
  def left(%__MODULE__{node: node = %BinTree{left: left}, focus: focus}) do
    %__MODULE__{node: left, focus: [{:left, node} | focus]}
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Zipper.t()) :: Zipper.t() | nil
  def right(%__MODULE__{node: %BinTree{right: nil}}), do: nil
  def right(%__MODULE__{node: node = %BinTree{right: right}, focus: focus}) do
    %__MODULE__{node: right, focus: [{:right, node} | focus]}
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Zipper.t()) :: Zipper.t() | nil
  def up(%__MODULE__{focus: []}), do: nil
  def up(%__MODULE__{node: node, focus: [{branch, parent} | focus]}) do
    %__MODULE__{node: Map.put(parent, branch, node), focus: focus}
  end


  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Zipper.t(), any) :: Zipper.t()
  def set_value(zipper = %__MODULE__{node: node}, value) do 
    %__MODULE__{zipper | node: %BinTree{node | value: value}}
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_left(zipper = %__MODULE__{node: node}, left) do
    %__MODULE__{zipper | node: %BinTree{node | left: left}}
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_right(zipper = %__MODULE__{node: node}, right) do
    %__MODULE__{zipper | node: %BinTree{node | right: right}}
  end
end
