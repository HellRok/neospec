class Neospec
  class Expector
    module ErrorExpectors
      def to_raise(expected_error, expected_message = nil)
        actual
        failed "to raise #{expected_error}, but nothing was raised"
      rescue => error
        if error.instance_of?(expected_error)
          if expected_message.nil?
            succeeded "to raise #{expected_error}"
          elsif expected_message == error.message
            succeeded "to raise #{expected_error}, '#{expected_message}'"
          else
            failed "to raise #{expected_error}, '#{expected_message}', but got #{error.class}, '#{error.message}'"
          end
        else
          failed "to raise #{expected_error}, but got #{error.class}"
        end
      end
    end
  end
end
