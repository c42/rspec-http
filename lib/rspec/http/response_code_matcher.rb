module RSpec
  module Http
    class ResponseCodeMatcher
      def initialize(expected_code)
        @expected_code = expected_code
      end

      def matches?(target)
        @target = target
        @target.status == @expected_code
      end

      def description
        "Response code should be #{@expected_code}"
      end

      def failure_message
        "Expected #{@target} to #{common_message}"
      end

      def negative_failure_message
        "Expected #{@target} to not #{common_message}"
      end

      def common_message
        message = "have a response code of #{@expected_code}, but got #{@target.status}"
        if @target.status == 302 || @target.status == 201
          message += " with a location of #{@target['Location'] || @target['location']}" 
        end
        message
      end
    end
  end
end
