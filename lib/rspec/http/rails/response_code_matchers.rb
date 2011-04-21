module RSpec
  module Rails
    module ResponseCodeMatchers
      RSpec::Http::StatusCodes.values.each do |code, status|
        define_method("be_#{Http::StatusCodes.as_valid_method_name(code)}") do
          RSpec::Http::ResponseCodeMatcher.new(code)
        end
      end
    end
  end
end