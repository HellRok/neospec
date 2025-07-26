class Neospec
  module Report
    module Basic
      def self.call(results, output: $stdout)
        output.puts "\n#{specs(results)}#{failures(results)}"
      end

      def self.specs(results)
        <<~STR.chomp
          Results:
            Specs:\t#{results.specs.size}
            Expectations:\t#{results.specs.sum { |spec| spec.expectations }}
        STR
      end

      def self.failures(results)
        return unless results.failures.any?

        output = "\n  Failures:\t#{results.failures.size}\n\n"
        output << "Failures:\n"

        output += results.failures.map do |failure|
          failure_output = ["  #{Neospec::Color::RED}#{failure.message}#{Neospec::Color::RESET}"]
          failure.stack.first(5).each do |location|
            failure_output << "    > #{location}"
          end

          failure_output.join("\n")
        end.join("\n\n")

        output
      end
    end
  end
end
