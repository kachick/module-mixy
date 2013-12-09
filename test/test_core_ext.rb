# coding: us-ascii

require_relative 'helper'
require_relative '../lib/module/mixy/core_ext'

upper_mod = Module.new do
  def not_want
  end
end

base_mod_1 = Module.new do
  include upper_mod
  
  def func
    :f1
  end

  private

  def private_func
    :pf1
  end
end

base_mod_2 = Module.new do
  def func
      :f2
  end
end

base_mod_3 = Module.new do
  private

  def private_func
    :pf3
  end
end


klass = Class.new

The klass.dup do |kls|
  ret = nil
  kls.module_eval do
    ret = mixy base_mod_1
  end

  SAME ret
  
  CATCH Module::Mixy::ConflictError do
    kls.module_eval do
      mixy base_mod_2
    end
  end

  CATCH Module::Mixy::ConflictError do
    kls.module_eval do
      mixy base_mod_3
    end
  end
end


The klass.dup do |kls|
  kls.module_eval do
    mixy base_mod_1
  end
  
  kls.module_eval do
    mixy base_mod_2, :func => :func2
    mixy base_mod_3, :private_func => :private_func3
  end
  
  methods = [:func2, :func] - kls.instance_methods(true).grep(/func\d?\z/)
  OK methods.empty?

  methods = [:private_func3, :private_func] - \
  kls.private_instance_methods(true).grep(/func\d?\z/)
  OK methods.empty?

  The kls.new do |instance|
    The instance.func do
      is :f1
    end
    
    The instance.func2 do
      is :f2
    end
    
    CATCH NoMethodError do
      instance.not_want
    end
  end
end