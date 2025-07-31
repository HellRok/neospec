class Neospec
  module Logger
    class Basic
      def initialize(output: $stdout)
        @output = output
      end

      def log(message, context: nil, result: nil)
        case context
        when :describe
          @output.puts "#{Neospec::Color::BLUE}#{message}#{Neospec::Color::RESET}"
        when :expect
          str = "    "
          str << (result.successful? ? "#{Neospec::Color::GREEN}✓" : "#{Neospec::Color::RED}✗")
          str << " #{context} #{message}#{Neospec::Color::RESET}"
          @output.puts str
        when :error
          @output.puts "    #{Neospec::Color::RED}✗ #{message}#{Neospec::Color::RESET}"
        else
          @output.puts "  #{context} #{message}"
        end
      end
    end
  end
end
