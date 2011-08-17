module RSpec
  module Matchers
    def fail_with(message)
      raise_error(RSpec::Expectations::ExpectationNotMetError, message)
    end
  end
end

