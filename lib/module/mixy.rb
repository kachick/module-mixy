# coding: us-ascii
# Copyright (c) 2012 Kenichi Kamiya

class Module

  module Mixy

    class ConflictError < NameError; end

    module_function

    def methods_from(mod)
      mod.instance_methods(true) | mod.private_instance_methods(true)
    end

    private

    # @param [Module] feature_module
    # @param [Hash] aliases - original => aliased
    # @return [self]
    def mixy(feature_module, aliases={})
      specific_module = specific_module_from feature_module, aliases
      
      conflicts = methods_from(self) & methods_from(specific_module)
      unless conflicts.empty?
        raise ConflictError, "[#{conflicts.join(', ')}] conflicts"
      end
      
      include specific_module
      self
    end

    def specific_module_from(feature_module, aliases)
      specific_module = feature_module.dup

      specific_module.module_eval do |mod|
        features = instance_methods(false) | private_instance_methods(false)
        ignores = Mixy.methods_from(specific_module) - (features | aliases.keys)
        undef_method(*ignores)
        
        aliases.each_pair do |original, aliased|
          alias_method aliased, original
          remove_method original
        end
      end

      specific_module
    end

  end

end
