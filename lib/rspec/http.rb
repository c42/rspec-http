require 'rspec/core'

require 'rspec/http/status_codes'
require 'rspec/http/response_code_matcher'
require 'rspec/http/response_code_matchers'
require 'rspec/http/header_matchers'

require 'rspec/http/rails'# if Kernel.const_defined?('Rails')

RSpec::configure do |config|
  config.include(RSpec::Http::ResponseCodeMatchers)
end