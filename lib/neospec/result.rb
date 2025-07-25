class Neospec
  class Result
    attr_accessor :expectations, :failures
    def initialize
      @expectations = 0
      @failures = 0
    end

    def successful? = @failures.zero?
  end
end
