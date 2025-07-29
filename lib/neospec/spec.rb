class Neospec
  class Spec
    COMMANDS = %w[Given And But When Then]

    def initialize(description:, block:)
      # Everything here is prefixed to prevent people's specs overriding it,
      # this came to be because I've already accidentally done this a few
      # times.
      @__result = Neospec::Spec::Result.new
      @__description = description
      @__block = block
    end

    def description
      @__description
    end

    def result
      @__result
    end

    def duration
      @__result.duration
    end

    def successful?
      @__result.successful?
    end

    def expectations
      @__result.expectations
    end

    def failures
      @__result.failures
    end

    def log(message, context: nil, result: nil)
      @__logger.log(message, context: context, result: result)
    end

    def run(logger:)
      @__logger = logger
      instance_exec { log(@__description, context: :describe) }
      result.start!
      instance_exec(&@__block)
      result.finish!
    end

    COMMANDS.each do |command|
      define_method(command) do |description, &block|
        log(description, context: command.to_sym)
        block.call
      end
    end

    def expect(value)
      Neospec::Expector.new(
        result: @__result,
        actual: value,
        stack: caller,
        logger: @__logger
      )
    end
  end
end
