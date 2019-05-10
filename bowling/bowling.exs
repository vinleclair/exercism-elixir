defmodule Bowling do
  defstruct [:rolls, :current_roll, :first_in_frame] 

  @last_frame 9  
  @amount_of_frames 21
  @perfect_frame_score 10

  @first_roll 0
  @perfect_game_last_roll 11
  @second_to_last_roll 18
  @last_roll 19
  @bonus_roll 20
  @not_rolled nil

  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """
  @spec start() :: any
  def start do
    %__MODULE__{rolls: List.duplicate(@not_rolled, @amount_of_frames), 
      current_roll: @first_roll, 
      first_in_frame: true}
  end

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful message.
  """
  @spec roll(any, integer) :: any | String.t()
  def roll(_, roll) when roll < 0, do: {:error, "Negative roll is invalid"}

  def roll(%__MODULE__{rolls: rolls, 
    current_roll: current_roll, 
    first_in_frame: first_in_frame}, roll) do
    cond do
      Enum.at(rolls, @last_roll) != @not_rolled and 
      (Enum.at(rolls, @second_to_last_roll) + Enum.at(rolls, @last_roll)) < @perfect_frame_score ->
        {:error, "Cannot roll after game is over"}

      roll > @perfect_frame_score or 
      (first_in_frame == false and roll + Enum.at(rolls, current_roll - 1) > @perfect_frame_score) ->
        {:error, "Pin count exceeds pins on the lane"}

      true ->
        %__MODULE__{
          rolls: List.replace_at(rolls, current_roll, roll), 
          current_roll: current_roll + 1,
          first_in_frame: 
          (if first_in_frame == false or 
          (first_in_frame == true and roll == @perfect_frame_score),
            do: true, else: false) 
            }
    end
  end

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful message.
  """
  @spec score(any) :: integer | String.t()
  def score(%__MODULE__{rolls: rolls}) do
      if incomplete_game?(rolls) or bonus_rolls_missing?(rolls) do
        {:error, "Score cannot be taken until the end of the game"}
      else
        do_score(0, rolls, 0, 0)
      end
  end

  defp do_score(score, rolls, current_frame, first_in_frame) do
    cond do
      current_frame > @last_frame ->
        score

      strike?(rolls, first_in_frame) ->
        do_score(score + @perfect_frame_score + next_two_balls_for_strike(rolls, first_in_frame),
          rolls, 
          current_frame + 1, 
          first_in_frame + 1)

      spare?(rolls, first_in_frame) ->
        do_score(score + @perfect_frame_score + next_ball_for_spare(rolls, first_in_frame), 
          rolls, 
          current_frame + 1, 
          first_in_frame + 2)

      true ->
        do_score(score + two_balls_in_frame(rolls, first_in_frame), 
          rolls, 
          current_frame + 1, 
          first_in_frame + 2)
    end
  end

  defp incomplete_game?(rolls) do 
    Enum.at(rolls, @first_roll) == @not_rolled or 
    Enum.at(rolls, @perfect_game_last_roll) == @not_rolled
  end 

  defp bonus_rolls_missing?(rolls) do
    (Enum.at(rolls, @second_to_last_roll) == @perfect_frame_score 
      and Enum.at(rolls, @last_roll) == @not_rolled) or
    (Enum.at(rolls, @last_roll) == @perfect_frame_score 
      and Enum.at(rolls, @bonus_roll) == @not_rolled) or
    (Enum.at(rolls, @second_to_last_roll) < @perfect_frame_score and 
      Enum.at(rolls, @last_roll) < @perfect_frame_score and 
      Enum.at(rolls, @second_to_last_roll) + Enum.at(rolls, @last_roll) == @perfect_frame_score 
      and Enum.at(rolls, @bonus_roll) == @not_rolled)
  end

  defp strike?(rolls, first_in_frame) do
    Enum.at(rolls, first_in_frame) == @perfect_frame_score
  end

  defp spare?(rolls, first_in_frame) do
    Enum.at(rolls, first_in_frame) + Enum.at(rolls, first_in_frame + 1) == @perfect_frame_score
  end

  defp next_two_balls_for_strike(rolls, first_in_frame) do
    Enum.at(rolls, first_in_frame + 1) + Enum.at(rolls, first_in_frame + 2)
  end
  
  defp next_ball_for_spare(rolls, first_in_frame) do
    Enum.at(rolls, first_in_frame + 2)
  end

  defp two_balls_in_frame(rolls, first_in_frame) do 
    Enum.at(rolls, first_in_frame) + Enum.at(rolls, first_in_frame + 1)
  end
end

