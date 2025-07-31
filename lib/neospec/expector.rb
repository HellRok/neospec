class Neospec
  class Expector
    include Neospec::Expector::EqualityExpectors
    include Neospec::Expector::InclusionExpectors
    include Neospec::Expector::ErrorExpectors

    attr_reader :failure, :result

    def initialize(result:, actual:, stack:, logger:)
      @actual = actual
      @stack = stack
      @logger = logger
      @result = result
    end

    def log(message, context: nil)
      @logger.log(message, context: context, result: @result)
    end

    def succeeded(message)
      @result.expectations += 1
      log(message, context: :expect)
    end

    def failed(message)
      @result.expectations += 1
      @result.failures << Neospec::Spec::Result::Failure.new(
        stack: @stack,
        message: "Expected #{message}"
      )

      log(message, context: :expect)
      raise Neospec::Spec::Result::FailureEncounteredError
    end

    def actual
      if @actual.is_a?(Proc)
        @actual = @actual.call
      end

      @actual
    end
  end
end
