module RSpec
  module Http
    module ResponseCodeMatchers
      RSpec::Http::StatusCodes.values.each do |code, status|
        define_method("be_http_#{Http::StatusCodes.as_valid_method_name(code)}") do
          ResponseCodeMatcher.new(code)
        end
      end
    end
  end
end