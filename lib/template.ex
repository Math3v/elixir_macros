defmodule Template do
  import Html

  def render do
    markup do
      table class: "test-class" do
        tr do
          for i <- 0..5 do
            td do
              text("Cell #{i}")
            end
          end
        end
      end
    end
  end
end
