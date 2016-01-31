defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def square(1), do: 1
  def square(number) do
    2 * square(number - 1)
  end

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total do
    tab(1, 1, 1)
  end

  defp tab(64, accum, _), do: accum
  defp tab(number, accum, total) do
    tab(number + 1, accum + total * 2, total * 2)
  end
end
