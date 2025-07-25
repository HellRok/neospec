class Neospec
  module Runner
    class Basic
      def initialize
        @results = Neospec::Results.new
      end

      def run(config:, suite:)
        @results
      end
    end
  end
end
