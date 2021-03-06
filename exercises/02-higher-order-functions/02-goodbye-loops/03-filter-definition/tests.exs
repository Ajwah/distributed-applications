defmodule Setup do
  @script "shared.exs"

  def setup(directory \\ ".") do
    path = Path.join(directory, @script)

    if File.exists?(path) do
      Code.require_file(path)
      Shared.setup(__DIR__)
    else
      setup(Path.join(directory, ".."))
    end
  end
end

Setup.setup


defmodule Tests do
  use ExUnit.Case, async: true
  import Shared
  import Integer


  check that: Util.filter([], &Integer.is_even/1), is_equal_to: []
  check that: Util.filter([1], &Integer.is_even/1), is_equal_to: []
  check that: Util.filter([2], &Integer.is_even/1), is_equal_to: [2]
  check that: Util.filter([1, 2], &Integer.is_even/1), is_equal_to: [2]
  check that: Util.filter([1, 2, 3], &Integer.is_even/1), is_equal_to: [2]
  check that: Util.filter([1, 2, 3, 4], &Integer.is_even/1), is_equal_to: [2, 4]
  check that: Util.filter([], &Integer.is_odd/1), is_equal_to: []
  check that: Util.filter([1], &Integer.is_odd/1), is_equal_to: [1]
  check that: Util.filter([1, 2], &Integer.is_odd/1), is_equal_to: [1]
  check that: Util.filter([1, 2], fn x -> x < 5 end), is_equal_to: [1, 2]
  check that: Util.filter([1, 2, 3, 4, 5], fn x -> x < 5 end), is_equal_to: [1, 2, 3, 4]
  check that: Util.filter([5, 6, 7, 8], fn x -> x < 5 end), is_equal_to: []
end
