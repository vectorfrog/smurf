defmodule SmurfTest do
  use ExUnit.Case
  doctest Smurf

  test "greets the world" do
    assert Smurf.hello() == :world
  end
end
