# coding: us-ascii
# Copyright (c) 2012 Kenichi Kamiya

class Module

  module Mixy

    class ConflictError < NameError; end

    # @param feature_module [Module]
    # @param aliases [Hash] origin<Symbol> => aliased<Symbol,nil,false>
    # @return [self]
    # if passes `aliases`, defines the renamed methods.
    # if aliases are not given, behaves as `include` with preventing to conflict.
    def mixy(feature_module, aliases={})
      specific_module = specific_module_from feature_module, aliases
      check_conflicts specific_module
      
      include specific_module
      self
    end

    module_function

    # @param mod [Module]
    # @return [Array<Symbol>]
    def methods_from(mod)
      mod.instance_methods(true) | mod.private_instance_methods(true)
    end

    private

    # @return [Module]
    def specific_module_from(feature_module, aliases)
      specific_module = feature_module.dup
      keep_features = methods_from self

      specific_module.module_eval do
        features = instance_methods(false) | private_instance_methods(false)
        ignores = Mixy.methods_from(specific_module) - (keep_features | features | aliases.keys)
        undef_method(*ignores)

        aliases.each_pair do |origin, aliased|
          alias_method aliased, origin if aliased

          if keep_features.include? origin
            remove_method origin
          else
            undef_method origin
          end
        end
      end

      specific_module
    end

    # @return [nil]
    def check_conflicts(specific_module)
      conflicts = methods_from(self) & methods_from(specific_module)
      conflicts.each do |conflict|
        err = ConflictError.new \
              "#{conflict} is a conflict name - all coflicts: [#{conflicts.join(', ')}]", conflict
        raise err
      end

      nil
    end

  end

end
