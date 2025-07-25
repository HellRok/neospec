class Neospec
  module Logger
    class Basic
      def initialize
      end

      def log(message, context: nil, result: nil)
        case context
        when :describe
          puts message
        when :Expect
          puts " #{result ? "✓" : "✗"} #{context} #{message}"
        else
          puts "   #{context} #{message}"
        end
      end
    end
  end
end
