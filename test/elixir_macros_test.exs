defmodule ElixirMacrosTest do
  use ExUnit.Case
  doctest ElixirMacros

  test "greets the world" do
    assert ElixirMacros.hello() == :world
  end
end
