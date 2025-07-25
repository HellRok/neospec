class Neospec
  module Runner
    class Basic
      def initialize
        @results = Neospec::Results.new
      end

      def run(config:, suite:)
        suite.specs.each do |spec|
          spec.run
          @results.record(spec.result)
        end

        @results
      end
    end
  end
end
