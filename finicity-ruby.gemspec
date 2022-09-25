# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "finicity/version"

Gem::Specification.new do |spec|
  spec.name          = "finicity-ruby"
  spec.version       = Finicity::VERSION
  spec.authors       = ["Azzurrio"]
  spec.email         = ["just.azzurri@gmail.com"]

  spec.summary       = "Ruby Client for Finicity Aggregation API"
  spec.description   = "Ruby Client for Finicity Aggregation API"
  spec.homepage      = "https://github.com/Fundthrough/finicity-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version     = ">= 2.3.0"
  spec.required_rubygems_version = ">= 2.0.0"

  spec.add_runtime_dependency "hashie", "~> 3.4.4"
  spec.add_runtime_dependency "httparty", "~> 0.20.0"
  spec.add_runtime_dependency "redis", "~> 4.7.1"
  spec.add_runtime_dependency "activesupport"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop"
end
