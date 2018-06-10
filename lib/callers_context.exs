defmodule WrappingModule do

  defmacro definfo do
    IO.puts "Macro's context (#{__MODULE__})"

    quote do
      IO.puts "Caller's context (#{__MODULE__})"

      def friendly_info do
        IO.puts "My module is #{__MODULE__}"
        IO.puts "My functions are #{inspect __info__(:functions)}"
      end
    end
  end
end

defmodule MyModule do
  require WrappingModule
  WrappingModule.definfo
end
