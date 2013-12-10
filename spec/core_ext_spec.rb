# coding: us-ascii

require_relative 'helper'
require_relative '../lib/module/mixy/core_ext'

describe Module::Mixy do
  it "can call #mixy on any modules" do
    mod = Module.new
    expect(mod.__send__(:mixy, Module.new)).to equal(mod)
  end
end