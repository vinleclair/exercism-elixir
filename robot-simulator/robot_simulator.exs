defmodule RobotSimulator do
  defstruct [:direction, :position]

  defguardp is_invalid_direction(direction) when direction not in [:north, :east, :south, :west] 
  defguardp is_invalid_position(position) when 
    not is_tuple(position) or 
    tuple_size(position) != 2 or 
    not is_integer(elem(position, 0)) or 
    not is_integer(elem(position, 1))

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
  def create(direction \\ :north, position \\ {0,0})
  def create(direction, _position) when is_invalid_direction(direction), do: {:error, "invalid direction"}
  def create(_direction, position) when is_invalid_position(position), do: {:error, "invalid position"}
  def create(direction, position), do: %RobotSimulator{direction: direction, position: position}
  
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

