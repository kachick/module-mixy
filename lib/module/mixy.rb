# Copyright (c) 2012 Kenichi Kamiya

class Module

  module Mixy

    class ConflictError < NameError; end

    private

    # @param [Module] feature_mod
    # @param [Hash] aliases - original => aliased
    # @return [self]
    def mixy(feature_mod, aliases={})
      specific_mod = feature_mod.dup

      all_methods_for = ->mod{
        mod.instance_methods(true) | mod.private_instance_methods(true)
      }

      specific_mod.module_eval do |mod|
        wants = instance_methods(false) | private_instance_methods(false)
        ignores = all_methods_for.call(specific_mod) - (wants | aliases.keys)
        undef_method(*ignores)
        
        aliases.each_pair do |original, aliased|
          alias_method aliased, original
          remove_method original
        end
      end
      
      conflicts = all_methods_for.call(self) & all_methods_for.call(specific_mod)
      unless conflicts.empty?
        raise ConflictError, "[#{conflicts.join(', ')}] conflicts"
      end
      
      include specific_mod
      self
    end

  end

end
