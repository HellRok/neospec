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
    end
  end
end
