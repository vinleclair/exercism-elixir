defmodule Bowling do
  defstruct [:rolls, :currentRoll, :firstInFrame] 

  @lastFrame 9  
  @amountOfFrames 21
  @perfectFrameScore 10

  @firstRoll 0
  @perfectGameLastRoll 11
  @secondToLastRoll 18
  @lastRoll 19
  @bonusRoll 20
  @notRolled nil

  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """
  @spec start() :: any
  def start do
    %__MODULE__{rolls: List.duplicate(@notRolled, @amountOfFrames), 
      currentRoll: @firstRoll, 
      firstInFrame: true}
  end

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful message.
  """
  @spec roll(any, integer) :: any | String.t()
  def roll(_, roll) when roll < 0, do: {:error, "Negative roll is invalid"}

  def roll(%__MODULE__{rolls: rolls, 
    currentRoll: currentRoll, 
    firstInFrame: firstInFrame}, roll) do
    cond do
      Enum.at(rolls, @lastRoll) != @notRolled and 
      (Enum.at(rolls, @secondToLastRoll) + Enum.at(rolls, @lastRoll)) < @perfectFrameScore ->
        {:error, "Cannot roll after game is over"}

      roll > @perfectFrameScore or 
      (firstInFrame == false and roll + Enum.at(rolls, currentRoll - 1) > @perfectFrameScore) ->
        {:error, "Pin count exceeds pins on the lane"}

      true ->
        %__MODULE__{
          rolls: List.replace_at(rolls, currentRoll, roll), 
          currentRoll: currentRoll + 1,
          firstInFrame: 
          (if firstInFrame == false or 
          (firstInFrame == true and roll == @perfectFrameScore),
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
      if incompleteGame?(rolls) or bonusRollsMissing?(rolls) do
        {:error, "Score cannot be taken until the end of the game"}
      else
        do_score(0, rolls, 0, 0)
      end
  end

  defp do_score(score, rolls, currentFrame, firstInFrame) do
    cond do
      currentFrame > @lastFrame ->
        score

      strike?(rolls, firstInFrame) ->
        do_score(score + @perfectFrameScore + nextTwoBallsForStrike(rolls, firstInFrame),
          rolls, 
          currentFrame + 1, 
          firstInFrame + 1)

      spare?(rolls, firstInFrame) ->
        do_score(score + @perfectFrameScore + nextBallForSpare(rolls, firstInFrame), 
          rolls, 
          currentFrame + 1, 
          firstInFrame + 2)

      true ->
        do_score(score + twoBallsInFrame(rolls, firstInFrame), 
          rolls, 
          currentFrame + 1, 
          firstInFrame + 2)
    end
  end

  defp incompleteGame?(rolls) do 
    Enum.at(rolls, @firstRoll) == @notRolled or 
    Enum.at(rolls, @perfectGameLastRoll) == @notRolled
  end 

  defp bonusRollsMissing?(rolls) do
    (Enum.at(rolls, @secondToLastRoll) == @perfectFrameScore 
      and Enum.at(rolls, @lastRoll) == @notRolled) or
    (Enum.at(rolls, @lastRoll) == @perfectFrameScore 
      and Enum.at(rolls, @bonusRoll) == @notRolled) or
    (Enum.at(rolls, @secondToLastRoll) < @perfectFrameScore and 
      Enum.at(rolls, @lastRoll) < @perfectFrameScore and 
      Enum.at(rolls, @secondToLastRoll) + Enum.at(rolls, @lastRoll) == @perfectFrameScore 
      and Enum.at(rolls, @bonusRoll) == @notRolled)
  end

  defp strike?(rolls, firstInframe) do
    Enum.at(rolls, firstInframe) == @perfectFrameScore
  end

  defp spare?(rolls, firstInFrame) do
    Enum.at(rolls, firstInFrame) + Enum.at(rolls, firstInFrame + 1) == @perfectFrameScore
  end

  defp nextTwoBallsForStrike(rolls, firstInFrame) do
    Enum.at(rolls, firstInFrame + 1) + Enum.at(rolls, firstInFrame + 2)
  end
  
  defp nextBallForSpare(rolls, firstInFrame) do
    Enum.at(rolls, firstInFrame + 2)
  end

  defp twoBallsInFrame(rolls, firstInFrame) do 
    Enum.at(rolls, firstInFrame) + Enum.at(rolls, firstInFrame + 1)
  end
end

