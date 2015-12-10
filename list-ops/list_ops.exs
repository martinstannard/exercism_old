defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l) do
    counter(l, 0)
  end

  def counter([head|tail], count) do
    1 + counter(tail, count)
  end

  def counter([], count) do
    0
  end

  @spec reverse(list) :: list
  def reverse(l) do
    _reverser(l)
  end

  def _reverser([head|tail]) do
    [ _reverser(tail) | head]
  end

  def _reverser([]) do
    []
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    mapper(l, f)
  end
  
  def mapper([head | tail], f) do
    [f.(head)| mapper(tail, f)]
  end

  def mapper([], f) do
    []
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    _filter(l, f, [])
  end

  defp _filter([], f, a) do
    a
  end

  defp _filter([head|tail], f, a) do
    case f.(head) do
      true -> 
        [ head | _filter(tail, f, a) ]
      false ->
        _filter(tail, f, a)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce(l, acc, f) do
    _reduce(l, acc, f)
  end

  defp _reduce([], acc, f) do
    acc
  end

  defp _reduce([head|tail], acc, f) do
    _reduce(tail, f.(head, acc), f)
  end

  @spec append(list, list) :: list
  def append(a, b) do
    _append(a, b)
  end

  def _append([], []) do
    []
  end

  def _append([], a) do
    a
  end

  def _append(a, []) do
    a
  end

  def _append([head|tail], b) do
    _append(head, _append(tail, b))
  end

  def _append(a, [head|tail]) do
    _append(_append(a, head), tail)
  end

#  def _append(a, b) do
    #[a, b]
  #end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    _concat(ll)
  end

  def _concat([]) do
    []
  end

  def _concat([head|tail]) do
    [_concat(head) | _concat(tail)]
  end

  def _concat(a) do
    a
  end

end
