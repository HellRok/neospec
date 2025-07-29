class Neospec
  module Runner
    class Basic
      def run(logger:, suite:)
        suite.setup.call
        suite.specs.each do |spec|
          suite.before.call
          spec.run(logger: logger)
          suite.after.call
        end
        suite.teardown.call
      end
    end
  end
end
