class Neospec
  module Logger
    class Basic
      attr_reader :output

      def initialize(output: $stdout)
        @output = output
      end

      def log(message, context: nil, result: nil)
        case context
        when :describe
          @output.puts message
        when :expect
          @output.puts "    #{result.successful? ? "✓" : "✗"} #{context} #{message}"
        else
          @output.puts "  #{context} #{message}"
        end
      end
    end
  end
end
