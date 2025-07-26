class Neospec
  class Spec
    class Result
      attr_accessor :expectations, :failures

      def initialize
        @expectations = 0
        @failures = []
      end

      def successful?
        @failures.empty?
      end
    end
  end
end
