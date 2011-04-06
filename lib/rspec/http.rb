require 'rspec/core'

require 'rspec/http/status_codes'
require 'rspec/http/response_code_matchers'

RSpec::configure do |config|
  config.include(RSpec::Http::ResponseCodeMatchers)
end