defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("123-456-7890")
  "1234567890"

  iex> Phone.number("+1 (303) 555-1212")
  "3035551212"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t) :: String.t
  def number(raw) do
    if contains_letters(raw) do
      "0000000000"
    else
      raw
      |> remove_symbols
      |> convert
    end
  end

  defp remove_symbols(number) do
    Regex.replace(~r/[^\d]/, number, "")
  end

  defp contains_letters(number) do
    Regex.match?(~r/[a-z]/, number)
  end

  defp convert(number) do
    case String.length(number) do
      10 -> number
      11 ->
        if first_is_one(number) do
          String.slice(number, 1, 12)
        else
          zero(String.slice(number, 0, 10))
        end
      _ -> "0000000000"
    end
  end

  defp zero(number) do
    Regex.replace(~r/\d/, number, "0")
  end

  defp first_is_one(number) do
    String.at(number, 0) == "1"
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("123-456-7890")
  "123"

  iex> Phone.area_code("+1 (303) 555-1212")
  "303"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    String.slice(convert(raw), 0, 3)
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("123-456-7890")
  "(123) 456-7890"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    area = area_code(raw)
    converted = convert(raw)
    mid = String.slice(converted, 3, 3)
    last = String.slice(converted, 6, 4)
    "(#{area}) #{mid}-#{last}"
  end
end
