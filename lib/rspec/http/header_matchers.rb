module RSpec
  module Http
    class HeaderMatcher
      attr_reader :header, :expected_value, :response
      NO_VALUE = Object.new
      
      def initialize(expected)
        @header, @expected_value = expected.kind_of?(String) ? [expected, NO_VALUE] : expected.first
      end
      
      def matches?(response)
        if response[header]
          @matcher = case expected_value
            when String then HeaderStringMatcher.new(header, expected_value)
            when Regexp then HeaderRegexpMatcher.new(header, expected_value)
            when NO_VALUE then HeaderPresenceMatcher.new(header)
            else raise SyntaxError.new("The value for a header should be either a String or a Regexp and not of type #{expected_value.class}")
          end
        else
          @matcher = HeaderPresenceMatcher.new(header)
        end
        @matcher.matches?(response)
      end
      
      def description
        @matcher.description
      end
      
      def failure_message
        @matcher.failure_message
      end
      
      def negative_failure_message
        @matcher.negative_failure_message
      end
    end
    
    class HeaderPresenceMatcher
      attr_reader :header, :expected_value, :response
      def initialize(header)
        @header = header
      end
      
      def matches?(response)
        @response = response
        validate
      end
      
      def validate
        response[header]
      end
      
      def description
        "Verify the presence of '#{header}' among the response headers"
      end

      def failure_message
        "The header '#{header}' was not found"
      end

      def negative_failure_message
        "The header '#{header}' should not have been found, but it was and it has a value of '#{response[header]}'"
      end
    end
    
    class HeaderStringMatcher < HeaderPresenceMatcher
      def initialize(header, expected_value)
        super(header)
        @expected_value = expected_value
      end

      def validate
        expected_value.downcase == response[header].downcase
      end

      def description
        "Verify that the value associated with '#{header}' is '#{expected_value}'"
      end

      def failure_message
        "Expected the response header '#{header}' to have a value of '#{expected_value}' but it was '#{@response[header]}'"
      end

      def negative_failure_message
        "Expected the response header '#{header}' to have a value that is not '#{expected_value}'"
      end
    end
    
    class HeaderRegexpMatcher < HeaderPresenceMatcher
      def initialize(header, expected_value)
        super(header)
        @expected_value =  expected_value
      end

      def validate
        expected_value =~ response[header]
      end

      def description
        "Verify the value associated with '#{header}' matches '#{expected_value}"
      end

      def failure_message
        "Expected the response header '#{header}' to have a value that matched #{expected_value.inspect} but it was '#{@response[header]}'"
      end

      def negative_failure_message
        "Expected the response header '#{header}' to have a value that does not match #{expected_value.inspect} but it was '#{@response[header]}'"
      end
    end
    
    module HeaderMatchers
      def have_header(expected)
        HeaderMatcher.new(expected)
      end
    end
  end
end
