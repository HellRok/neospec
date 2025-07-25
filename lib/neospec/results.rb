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
  end
end
