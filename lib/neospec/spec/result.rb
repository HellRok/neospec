class Neospec
  class Spec
    class Result
      attr_accessor :expectations, :failures, :start, :finish

      def initialize
        @expectations = 0
        @failures = []
        @start = nil
        @finish = nil
      end

      def successful?
        @failures.empty?
      end

      def start!
        @start = Time.now
      end

      def finish!
        @finish = Time.now
      end

      def duration
        return if @start.nil? || @finish.nil?
        @finish - @start
      end
    end
  end
end
