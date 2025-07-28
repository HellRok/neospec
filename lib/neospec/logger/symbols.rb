class Neospec
  module Logger
    class Symbols
      def initialize(color: true, output: $stdout)
        @color = color
        @output = output
      end

      def log(message, context: nil, result: nil)
        if context == :expect
          @output.write "#{
            result.successful? ? "#{Neospec::Color::GREEN}✓" : "#{Neospec::Color::RED}✗"
          }#{Neospec::Color::RESET}"
        end
      end
    end
  end
end
