module C42
  module Matchers
    STATUS_CODES = Rack::Utils::HTTP_STATUS_CODES.merge({
      102 => "Processing",
      207 => "Multi-Status",
      226 => "I'm Used",
      418 => "I'm A Teapot",
      422 => "Unprocessable Entity",
      423 => "Locked",
      424 => "Failed Dependency",
      426 => "Upgrade Required",
      507 => "Insufficient Storage",
      510 => "Not Extended"
    }).freeze

    # Provides a symbol-to-fixnum lookup for converting a symbol (like
    # :created or :not_implemented) into its corresponding HTTP status
    # code (like 200 or 501).
    SYMBOL_TO_STATUS_CODE = STATUS_CODES.inject({}) { |hash, (code, message)|
      hash[message.gsub(/(\s|-)/, "_").gsub('\'', '').downcase.to_sym.tap{|s|p s}] = code
      hash
    }.freeze

    class HttpResponseCodeMatcher
      def initialize(expected_code)
        @expected_code = expected_code
      end

      def matches?(target)
        @target = target
        @target.code.to_i == @expected_code
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
        message = "have a response code of #{@expected_code}, but got #{@target.code}"
        if @target.code.to_i == 302
          message += " with a location of #{@target['Location'] || @target['location']}" 
        end
        message
      end
    end

    SYMBOL_TO_STATUS_CODE.each do |symbol, code|
      define_method("be_#{symbol}") do
        HttpResponseCodeMatcher.new(code)
      end
    end
  end
end
