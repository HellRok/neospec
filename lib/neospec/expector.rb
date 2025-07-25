class Neospec
  class Expector
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
        message: message
      )

      log(message, context: :expect)
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
        failed "'#{expected}' not to equal '#{@actual}'"
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
