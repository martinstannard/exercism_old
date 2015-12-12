defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do

    if length(a) > length(b) do
      do_compare(b, a, :superlist)
    else
      do_compare(a, b, :sublist)
    end
  end

  defp do_compare(a, b, sub) do
    case subby(a, b) do
      true ->
        if length(a) == length(b) do
          :equal
        else
          sub
        end
      false ->
        :unequal
    end
  end

  defp subby(a, b), do: is_sub(a, b, a, b)

  def is_sub([], _, _, _), do: true
  def is_sub(_, [], _, _), do: false
  def is_sub([h1|t1], [h2|t2], list1, [hl2|tl2]) do
    case h1 === h2 do
      true -> is_sub(t1, t2, list1, [hl2|tl2]) 
      _ -> is_sub(list1, tl2, list1, [h2|t2])
    end
  end
  def is_sub(a, [h|t], _, _), do: a === h

end
