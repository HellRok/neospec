class Neospec
  module Logger
    class Basic
      def initialize(color: true, output: $stdout)
        @color = color
        @output = output
      end

      def log(message, context: nil, result: nil)
        case context
        when :describe
          if @color
            @output.puts "#{BLUE}#{message}#{RESET}"
          else
            @output.puts message
          end
        when :expect
          if @color
            str = "    "
            str << (result.successful? ? "#{GREEN}✓" : "#{RED}✗")
            str << " #{context} #{message}#{RESET}"
            @output.puts str
          else
            @output.puts "    #{result.successful? ? "✓" : "✗"} #{context} #{message}"
          end
        else
          @output.puts "  #{context} #{message}"
        end
      end
    end
  end
end
