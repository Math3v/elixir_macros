defmodule Assertion do
  defmacro assert({operator, _ctx, [lhs, rhs]}) do
    quote bind_quoted: [operator: operator, lhs: lhs, rhs: rhs] do
      Assertion.Test.assert(operator, lhs, rhs)
    end
  end
end

defmodule Assertion.Test do
  def assert(:<, lhs, rhs) when lhs < rhs do
    IO.puts "."
  end

  def assert(:<, lhs, rhs) do
    IO.puts """
      ERROR:
      #{lhs} expected to be lower than #{rhs}
    """
  end
end
