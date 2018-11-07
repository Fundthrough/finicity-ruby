# -*- encoding: utf-8 -*-
# stub: finicity-ruby 1.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "finicity-ruby".freeze
  s.version = "1.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 2.0.0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Azzurrio".freeze]
  s.bindir = "exe".freeze
  s.date = "2018-10-30"
  s.description = "Ruby Client for Finicity Aggregation API".freeze
  s.email = ["just.azzurri@gmail.com".freeze]
  s.files = [
    ".gitignore".freeze,
    ".rspec".freeze,
    ".rubocop.yml".freeze,
    ".ruby-gemset".freeze,
    ".ruby-version".freeze,
    ".travis.yml".freeze,
    "CODE_OF_CONDUCT.md".freeze,
    "Gemfile".freeze,
    "LICENSE.txt".freeze,
    "README.md".freeze,
    "Rakefile".freeze,
    "bin/console".freeze,
    "bin/setup".freeze,
    "finicity-ruby.gemspec".freeze,
    "lib/finicity-ruby.rb".freeze,
    "lib/finicity/client.rb".freeze,
    "lib/finicity/configurable.rb".freeze,
    "lib/finicity/fetchers.rb".freeze,
    "lib/finicity/fetchers/api.rb".freeze,
    "lib/finicity/fetchers/base.rb".freeze,
    "lib/finicity/fetchers/token.rb".freeze,
    "lib/finicity/resources/account.rb".freeze,
    "lib/finicity/resources/base.rb".freeze,
    "lib/finicity/resources/consumer.rb".freeze,
    "lib/finicity/resources/customer.rb".freeze,
    "lib/finicity/resources/institution.rb".freeze,
    "lib/finicity/resources/transaction.rb".freeze,
    "lib/finicity/version.rb".freeze
  ]
  s.homepage = "https://github.com/Fundthrough/finicity-ruby".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3.0".freeze)
  s.rubygems_version = "2.7.6".freeze
  s.summary = "Ruby Client for Finicity Aggregation API".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  s.add_development_dependency(%q<bundler>.freeze, ["~> 1.11"])
  s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
  s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
  s.add_development_dependency(%q<rubocop>.freeze, [">= 0"])
  s.add_development_dependency 'fakeredis', '~> 0.7.0'
  s.add_development_dependency 'awesome_print', '1.8.0'
  s.add_development_dependency 'byebug', '10.0.2'

  s.add_runtime_dependency(%q<hashie>.freeze, ["~> 3.4.4"])
  s.add_runtime_dependency(%q<httparty>.freeze, ["~> 0.14.0"])
  s.add_runtime_dependency(%q<redis>.freeze, ["~> 3.3.1"])
  s.add_runtime_dependency(%q<activesupport>.freeze, [">= 0"])

end
