#!/usr/bin/env rake
# coding: us-ascii

require 'bundler/gem_tasks'

require 'rake/testtask'
require 'rspec/core/rake_task'

task default: [:test, :spec]

Rake::TestTask.new do |tt|
  tt.verbose = true
  tt.warning = true
end

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.ruby_opts = %w[-w]
end