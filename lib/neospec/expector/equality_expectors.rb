class Neospec
  class Expector
    module EqualityExpectors
      def to_be_nil
        if actual.nil?
          succeeded "to be nil"
        else
          failed "'#{actual}' to be nil"
        end
      end

      def to_equal(expected)
        if actual == expected
          succeeded "to be equal"
        else
          failed "'#{expected}' to equal '#{actual}'"
        end
      end

      def not_to_equal(expected)
        if actual != expected
          succeeded "not to be equal"
        else
          failed "not to equal '#{actual}'"
        end
      end

      def to_be_a(expected)
        if actual.is_a?(expected)
          succeeded "to be a #{expected}"
        else
          failed "#{actual.class} to be a #{expected}"
        end
      end
    end
  end
end
