defmodule Assertion do

  defmacro __using__(_options) do
    quote do
      import unquote(__MODULE__)
      Module.register_attribute __MODULE__, :tests, accumulate: true
      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def run do
        Assertion.Test.run(@tests, __MODULE__)
      end
    end
  end

  defmacro test(description, do: test_block) do
    fn_name = String.to_atom(description)
    quote do
      @tests {unquote(fn_name), unquote(description)}
      def unquote(fn_name)() do
        unquote(test_block)
      end
    end
  end

  defmacro assert({operator, _ctx, [lhs, rhs]}) do
    quote bind_quoted: [operator: operator, lhs: lhs, rhs: rhs] do
      Assertion.Test.assert(operator, lhs, rhs)
    end
  end
end

defmodule Assertion.Test do
  def run(tests, module) do
    Enum.each tests, fn {fn_name, _desc} ->
      case apply(module, fn_name, []) do
        :ok             -> IO.write "."
        {:fail, reason} -> IO.puts reason
      end
    end
  end

  def assert(:<, lhs, rhs) when lhs < rhs do
    :ok
  end

  def assert(:<, lhs, rhs) do
    {:fail, """
    ERROR:
    #{lhs} expected to be lower than #{rhs}
    """
  }
end

def assert(:&&, true, true) do
  :ok
end

def assert(:&&, lhs, rhs) do
  {:fail, """
  ERROR:
  #{lhs} && #{rhs} expected to be true
  """
}
end
end
