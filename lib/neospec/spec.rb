class Neospec
  class Spec
    COMMANDS = %w[Given And But Or When Then]

    def initialize(description:, block:, stack: caller)
      # Everything here is prefixed to prevent people's specs overriding it,
      # this came to be because I've already accidentally done this a few
      # times.
      @__result = Neospec::Spec::Result.new
      @__description = description
      @__block = block
      @__stack = stack
    end

    def description
      @__description
    end

    def location
      # When run in a Taylor exported application, this is for nil due to the
      # code having been run through mrbc (I believe)
      @__stack.first || ""
    end

    def file_name
      location.split(":").first || ""
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
    rescue Neospec::Spec::Result::FailureEncounteredError
      # Do nothing
    rescue => error
      failures << Neospec::Spec::Result::Failure.new(
        stack: error.backtrace,
        message: "Raised #{error.class}, '#{error.message}'"
      )
      @__logger.log("raised #{error.class}", context: :error, result: result)
    ensure
      result.finish!
    end

    COMMANDS.each do |command|
      define_method(command) do |description, &block|
        log(description, context: command.to_sym)
        block.call
      end
    end

    def expect(value = nil, &block)
      raise ArgumentError, "Can't specify value AND pass a block" if value && block_given?

      Neospec::Expector.new(
        result: @__result,
        actual: block_given? ? block : value,
        stack: caller,
        logger: @__logger
      )
    end
  end
end
