require 'rspec/core'

require 'rspec/http/status_codes'
require 'rspec/http/response_code_matcher'
require 'rspec/http/response_code_matchers'
require 'rspec/http/header_matchers'

require 'rspec/http/rails'

RSpec::configure do |config|
  config.include(RSpec::Http::ResponseCodeMatchers)
  config.include(RSpec::Http::HeaderMatchers)
end