defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @schedule_ordinal %{:first => 1, :second => 2,
                      :third => 3, :fourth => 4,
                      :last => 5, :teenth => 6}

  @day_ordinal %{:monday => 1, :tuesday => 2, :wednesday => 3,
             :thursday => 4, :friday => 5, :saturday => 6,
             :sunday => 7}

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, :teenth) do
    day = Map.get(@day_ordinal, weekday)
    start_day = :calendar.day_of_the_week(year, month, 1)
    {year, month, find_teenth_day({1, start_day}, day)}
  end

  def meetup(year, month, weekday, :last) do
    day = Map.get(@day_ordinal, weekday)
    start_day = :calendar.day_of_the_week(year, month, 1)
    last_day = :calendar.last_day_of_the_month(year, month)
    {year, month, find_last_day({1, start_day}, day, last_day, 0)}
  end

  def meetup(year, month, weekday, schedule) do
    day = Map.get(@day_ordinal, weekday)
    start_day = :calendar.day_of_the_week(year, month, 1)
    sched = Map.get(@schedule_ordinal, schedule)
    {year, month, find_nth_day({1, start_day}, day, sched)}
  end

  defp find_nth_day({index, current}, target, 0), do: index - 1 
  defp find_nth_day({index, current}, current, count) do
    find_nth_day(inc_day(index, current), current, count - 1)
  end
  defp find_nth_day({index, current}, target, count) do
    find_nth_day(inc_day(index, current), target, count)
  end

  defp find_teenth_day({index, current}, target) when (target == current and index > 12), do: index
  defp find_teenth_day({index, current}, target) do
    find_teenth_day(inc_day(index, current), target)
  end

  defp find_last_day({index, current}, target, last, hit) when (index > last), do: hit
  defp find_last_day({index, current}, current, last, hit) do
    find_last_day(inc_day(index, current), current, last, index)
  end
  defp find_last_day({index, current}, target, last, hit) do
    find_last_day(inc_day(index, current), target, last, hit)
  end

  defp inc_day(index, current), do: {index + 1, roll(current)}
  defp roll(current), do: rem(current, 7) + 1
end
