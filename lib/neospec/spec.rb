class Neospec
  class Spec
    COMMANDS = %w[Given And But When Then]

    def initialize(logger:, description:, block:)
      # Everything here is prefixed to prevent people's specs overriding it,
      # this came to be because I've already accidentally done this a few
      # times.
      @__result = Neospec::Spec::Result.new
      @__logger = logger
      @__description = description
      @__block = block
    end

    def result = @__result

    def log(message, context: nil, result: nil)
      @__logger.log(message, context: context, result: result)
    end

    def run
      instance_exec { log(@__description, context: :describe) }
      instance_exec(&@__block)
    end

    COMMANDS.each do |command|
      define_method(command) do |description, &block|
        block_result = block.call
        log(description, context: command.to_sym, result: block_result)
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
