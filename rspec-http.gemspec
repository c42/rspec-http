# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "rspec/http/version"

Gem::Specification.new do |s|
  s.name        = "rspec-http"
  s.version     = RSpec::Http::Version::STRING
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Sidu Ponnappa", "Niranjan Paranjape"]
  s.email       = "ckponnappa@gmail.com"
  s.homepage    = "http://c42.in/open_source"
  s.summary     = "RSpec HTTP is an extension library that makes it easier to write specs for HTTP/REST APIs"
  s.description = "RSpec HTTP is an extension library that makes it easier to write specs for HTTP/REST APIs"

  s.rubygems_version   = "1.3.7"

  s.files            = `git ls-files`.split("\n") - ['.gitignore']
  s.test_files       = `git ls-files -- {spec}/*`.split("\n")
  s.extra_rdoc_files = [ "README.rdoc" ]
  s.rdoc_options     = ["--charset=UTF-8"]
  s.require_path     = "lib"

  s.add_runtime_dependency "rspec", ">= 2.0", "< 4.0"
end
