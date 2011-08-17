module RSpec
  module Http
    class HeaderMatcher
      def initialize(expected)
        @expected = expected
      end

      def expected_header_tuple
        @expected.is_a?(String) ? [@expected, true] : @expected.first
      end

      def matches?(actual)
        @response = actual
        header, expected_value = expected_header_tuple
        actual_value = actual[header]
        return expected_value == actual_value if expected_value.is_a? String
        return expected_value =~ actual_value if expected_value.is_a? Regexp
        actual_value
      end

      def description
        ""
      end

      def failure_message
        ""
      end

      def negative_failure_message
        ""
      end

      def common_message
        ""
      end
    end
    
    module HeaderMatchers
      def have_header(header)
        HeaderMatcher.new(header)
      end
    end
  end
end