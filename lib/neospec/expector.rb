class Neospec
  class Expector
    attr_reader :failure

    def initialize(result:, actual:, stack:, logger:)
      @actual = actual
      @stack = stack
      @logger = logger
      @result = result
    end

    def succeeded(message)
      @result.expectations += 1
      @logger.log(message, context: :expect, result: true)
    end

    def failed(message)
      @result.expectations += 1
      @result.failures << Neospec::Spec::Result::Failure.new(
        stack: @stack,
        message: message
      )

      @logger.log(message, context: :expect, result: false)
    end

    def to_equal(expected)
      if @actual == expected
        succeeded "to be equal"
      else
        failed "'#{expected}' to equal '#{@actual}'"
      end
    end

    def not_to_equal(expected)
      if @actual != expected
        succeeded "not to be equal"
      else
        failed "'#{expected}' to not equal '#{@actual}'"
      end
    end

    def to_be_a(expected)
      if @actual.is_a?(expected)
        succeeded "to be a #{expected}"
      else
        failed "'#{expected}' to equal '#{@actual.class}'"
      end
    end
  end
end
