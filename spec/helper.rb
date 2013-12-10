# coding: us-ascii

require 'rspec'

require_relative '../lib/module/mixy'
require_relative 'fixtures'

RSpec.configure do |configuration|
  configuration.include Module::Mixy::RspecHelpers
end

include Module::Mixy::RspecHelpers