defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(Dict.t, String.t, pos_integer) :: Dict.t
  def add(db, name, grade) do
    current_names = Map.get(db, grade, [])
    Map.put(db, grade, current_names ++ [name])
  end

  @doc """
  Return the names of the students in a particular grade.
  """
  @spec grade(Dict.t, pos_integer) :: [String]
  def grade(db, grade) do
    Map.get(db, grade, [])
  end

  @doc """
  Sorts the school by grade and name.
  """
  @spec sort(Dict) :: Dict.t
  def sort(db) do
    sort_grades(Enum.sort(db), %{})
  end

  defp sort_grades([], dict), do: dict

  defp sort_grades([{grade, names}|tail], dict) do
    sort_grades(tail, Map.put(dict, grade, Enum.sort(names)))
  end

end
