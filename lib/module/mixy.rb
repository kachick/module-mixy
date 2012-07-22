# Copyright (c) 2012 Kenichi Kamiya

class Module

  module Mixy

    VERSION = '0.0.1'.freeze
    
    class ConflictError < StandardError; end

  end

  private

  # @param [Module] base_mod
  # @param [Hash] aliases
  def mixy(base_mod, aliases={})
    specific_mod = base_mod.dup
    specific_mod.instance_eval do |mod|

      aliases.each_pair do |old, aliased|
        alias_method aliased, old
        remove_method old
      end

    end

    conflicts = instance_methods & specific_mod.instance_methods
    unless conflicts.empty?
      raise Mixy::ConflictError, "[#{conflicts.join(', ')}] conflicts"
    end

    include specific_mod
  end


end
