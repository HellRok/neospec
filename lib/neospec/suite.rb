class Neospec
  class Suite
    attr_accessor :specs, :runner

    def initialize(runner: Neospec::Runner::Basic.new)
      @runner = runner
      @specs = []
      @setup = -> {}
      @teardown = -> {}
      @before = -> {}
      @after = -> {}
    end

    def results
      @specs.map(&:result)
    end

    def describe(description, &block)
      @specs << Neospec::Spec.new(
        description: description,
        block: block
      )
    end

    def setup(&block)
      if block_given?
        @setup = block
      else
        @setup
      end
    end

    def teardown(&block)
      if block_given?
        @teardown = block
      else
        @teardown
      end
    end

    def before(&block)
      if block_given?
        @before = block
      else
        @before
      end
    end

    def after(&block)
      if block_given?
        @after = block
      else
        @after
      end
    end

    def run(logger:)
      runner.run(
        logger: logger,
        suite: self
      )
    end
  end
end
