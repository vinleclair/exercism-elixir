defmodule RobotSimulator do
  defstruct [:direction, :position]

  @turn_left %{
    :north => :west, 
    :east => :north, 
    :south => :east, 
    :west => :south
  }
  @turn_right %{
    :north => :east, 
    :east => :south, 
    :south => :west, 
    :west => :north
  }
  @advance %{
    :north => {0, 1}, 
    :east => {1, 0}, 
    :south => {0, -1}, 
    :west => {-1, 0}
  }

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0}) do
    cond do 
      is_invalid_direction(direction) ->
        {:error, "invalid direction"}

      is_invalid_position(position) ->
        {:error, "invalid position"}

      true ->
        %RobotSimulator{direction: direction, position: position}
    end
  end
  
  defp is_invalid_direction(direction), do: direction not in [:north, :east, :south, :west]

  defp is_invalid_position(position) do
    cond do
      !is_tuple(position) ->
        true

      tuple_size(position) != 2 ->
        true

      !(position |> Tuple.to_list |> Enum.all?(&is_integer(&1))) ->
        true

      true ->
        false
    end
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    instructions
    |> String.codepoints
    |> Enum.reduce_while(robot, fn direction, robot -> 
      if direction in ["L", "R", "A"] do
        {:cont, move(direction, robot)}
      else
        {:halt, {:error, "invalid instruction"}}
      end
    end)
  end

  defp move("L", robot), do: %{robot | direction: Map.fetch!(@turn_left, direction(robot))}
  defp move("R", robot), do: %{robot | direction: Map.fetch!(@turn_right, direction(robot))}

  defp move("A", robot) do
    {x, y} = position(robot)
    {dx, dy} = Map.fetch!(@advance, direction(robot))
    %{robot | position: {x + dx, y + dy}}
  end

  @doc """
  Return the robot's direction.
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    robot.position
  end
end

