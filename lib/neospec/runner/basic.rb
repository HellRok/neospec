class Neospec
  module Runner
    class Basic
      attr_accessor :config, :results

      def initialize(config:)
        @config = config
        @results = Neospec::Results.new
      end

      def run(suite:)
        suite.specs.each do |spec|
          spec.run
          @results.record(spec.result)
        end
      end
    end
  end
end
