# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_mysql/version'

Gem::Specification.new do |spec|
  spec.name          = "rails_mysql"
  spec.version       = RailsMysql::VERSION
  spec.authors       = ["Matt Burke"]
  spec.email         = ["burkemd1+github@gmail.com"]
  spec.summary       = %q{Adds a few mysql tool wrappers as rake tasks.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rake"

  # This is really only good for CI and for local development
  if RUBY_VERSION == "1.8.7"
    spec.add_runtime_dependency "rails", "< 4.0"
  else
    spec.add_runtime_dependency "rails"
  end

  spec.add_development_dependency "rspec"
end
