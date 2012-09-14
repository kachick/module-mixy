$VERBOSE = true

require_relative '../lib/module/mixy'
require 'declare'


upper_mod = Module.new do
  def not_want
  end
end

base_mod_1 = Module.new do
  include upper_mod
  
  def func
    :DUMMY1
  end
end

base_mod_2 = Module.new do    
  def func
      :DUMMY2
  end
end

klass = Class.new

The klass.dup do |kls|
  kls.module_eval do
    mixy base_mod_1
  end
  
  CATCH Module::Mixy::ConflictError do
    kls.module_eval do
      mixy base_mod_2
    end
  end
end


The klass.dup do |kls|
  kls.module_eval do
    mixy base_mod_1
  end
  
  kls.module_eval do
    mixy base_mod_2, :func => :func2
  end
  
  The kls.instance_methods(true).grep(/\Afunc/) do
    is [:func2, :func]
  end
  
  The kls.new do |instance|
    
    The instance.func do
      is :DUMMY1
    end
    
    The instance.func2 do
      is :DUMMY2
    end
    
    CATCH NoMethodError do
      instance.not_want
    end

  end

end
  
Declare.report
