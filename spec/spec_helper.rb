$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'finicity-ruby'
require 'simplecov'
# require 'codecov'

SimpleCov.start
# SimpleCov.formatter = SimpleCov::Formatter::Codecov
