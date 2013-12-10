#!/usr/bin/env rake
# coding: us-ascii

require 'bundler/gem_tasks'

require 'rspec/core/rake_task'

task default: [:spec]

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.ruby_opts = %w[-w]
end