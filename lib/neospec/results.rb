class Neospec
  class Results
    attr_reader :specs

    def initialize
      @specs = []
    end

    def record(result)
      @specs << result
    end

    def <<(other)
      @specs += other.specs
    end

    def successful?
      @specs.all?(&:successful?)
    end

    def failures
      @specs.flat_map(&:failures)
    end

    def duration
      @specs.sum(0, &:duration)
    end

    def expectations
      @specs.sum(0, &:expectations)
    end
  end
end
