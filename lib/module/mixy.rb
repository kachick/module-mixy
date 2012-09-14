# Copyright (C) 2012 Kenichi Kamiya

class Module

  module Mixy

    class ConflictError < NameError; end

    private

    # @param [Module] base_mod
    # @param [Hash] aliases - original => aliased
    # @return self
    def mixy(base_mod, aliases={})
      specific_mod = base_mod.dup
      specific_mod.module_eval do |mod|
        all_methods  = instance_methods(true)  | private_instance_methods(true)
        own_methods  = instance_methods(false) | private_instance_methods(false)
        will_aliases = aliases.keys
        
        undef_method(*(all_methods - (own_methods | will_aliases)))
        
        aliases.each_pair do |original, aliased|
          alias_method aliased, original
          remove_method original
        end
      end
      
      conflicts = instance_methods & specific_mod.instance_methods
      unless conflicts.empty?
        raise Mixy::ConflictError, "[#{conflicts.join(', ')}] conflicts"
      end
      
      include specific_mod
    end

  end

  include Mixy

end
