class Neospec
  class Spec
    class Result
      class Failure
        attr_reader :stack, :message

        def initialize(stack:, message:)
          @stack = stack
          @message = message
        end
      end
    end
  end
end
