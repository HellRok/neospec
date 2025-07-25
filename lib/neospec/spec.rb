class Neospec
  class Spec
    COMMANDS = %w[Given And But When Then]

    attr_reader :result, :logger, :description
    attr_accessor :block

    def initialize(logger:, description:, block:)
      @result = Neospec::Spec::Result.new
      @logger = logger
      @description = description
      @block = block
    end

    def log(message, context: nil, result: nil)
      @logger.log(message, context: context, result: result)
    end

    def run
      instance_exec { log @description, context: :describe }
      instance_exec(&@block)
    end

    COMMANDS.each do |command|
      define_method(command) do |description, &block|
        block_result = block.call
        log(description, context: command.to_sym, result: block_result)
      end
    end

    def Expect(description, &block)
      block_succeeded = !!block.call

      @result.expectations += 1
      @result.failures << caller[0] unless block_succeeded

      log(description, context: :Expect, result: block_succeeded)
    end
  end
end
