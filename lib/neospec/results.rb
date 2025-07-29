class Neospec
  class Results
    attr_accessor :suites

    def initialize(suites: [])
      @suites = suites
    end

    def specs
      @suites.flat_map(&:specs)
    end

    def successful?
      specs.all?(&:successful?)
    end

    def failures
      specs.flat_map(&:failures)
    end

    def duration
      specs.sum(0, &:duration)
    end

    def expectations
      specs.sum(0, &:expectations)
    end
  end
end
