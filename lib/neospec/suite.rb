class Neospec
  class Suite
    attr_accessor :specs, :runner

    def initialize(runner: Neospec::Runner::Basic.new)
      @runner = runner
      @specs = []
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

    def run(logger:)
      runner.run(
        logger: logger,
        suite: self
      )
    end
  end
end
