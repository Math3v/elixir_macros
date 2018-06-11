defmodule MathTest do
  use Assertion

  test "some integers are smaller than others" do
    assert 1 < 5
    assert 3 < 4 + 2
    assert 5 + 1 < 8 + 8
  end
end
