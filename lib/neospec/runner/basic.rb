class Neospec
  module Runner
    class Basic
      def run(logger:, suite:)
        suite.specs.each do |spec|
          spec.run(logger: logger)
        end
      end
    end
  end
end
