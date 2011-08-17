require 'rspec/http'
require 'rack'

Dir['./spec/support/**/*'].each {|f| require f}

RSpec::configure do |config|
  config.color_enabled = true
end
