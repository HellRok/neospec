class Neospec
  class Expector
    module InclusionExpectors
      def to_include(expected)
        if actual.include? expected
          succeeded "to include '#{expected}'"
        else
          failed "#{actual} to include '#{expected}'"
        end
      end

      def not_to_include(expected)
        if actual.include? expected
          failed "#{actual} not to include '#{expected}'"
        else
          succeeded "not to include '#{expected}'"
        end
      end

      def to_be_in(expected)
        if expected.include? actual
          succeeded "to be in #{expected}"
        else
          failed "'#{actual}' to be in #{expected}"
        end
      end

      def not_to_be_in(expected)
        if expected.include? actual
          failed "'#{actual}' not to be in #{expected}"
        else
          succeeded "not to be in #{expected}"
        end
      end
    end
  end
end
