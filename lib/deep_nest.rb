# frozen_string_literal: true

require_relative 'deep_nest/helpers'
require_relative 'deep_nest/version'

##
# Primary namespace for the deep_nest gem.
module DeepNest
  ##
  # Default error class for DeepNest module.
  class Error < StandardError; end
  class << self
    ##
    # Returns a deep copy of the passed hash or array.
    #
    # @param structure [Hash, Array] The hash or array to be deep copied.
    #
    # @return [Hash, Array] The deep copy of the passed hash or array.
    def deep_dup(structure)
      case structure
      when Array
        structure.map { |x| deep_dup(x) }
      when Hash
        structure.transform_values { |v| deep_dup(v) }
      else
        structure.dup
      end
    end

    ##
    # Returns a hash with the passed hashes recursively merged. An optional block can be passed to merge values.
    #
    # @param hash1 [Hash] The first hash to be merged.
    #
    # @param hash2 [Hash] The second hash to be merged.
    #
    # @yield [&block] Operation to merge values of the hashes.
    #
    # @return [Hash] The hash with recursively merged hashes.
    def deep_merge(hash1, hash2, &block)
      raise Error, 'Parameters must be hashes' unless hash1.is_a?(Hash) && hash2.is_a?(Hash)

      hash1.merge(hash2) do |k, v1, v2|
        if v1.is_a?(Hash) && v2.is_a?(Hash)
          deep_merge(v1, v2, &block)
        elsif block_given?
          block.call(k, v1, v2)
        else
          v2
        end
      end
    end

    ##
    # Returns true if the passed parameters are same in structure and values, false otherwise.
    #
    # @param struct1 [Hash, Array] First structure to be compared.
    #
    # @param struct2 [Hash, Array] Second structure to be compared.
    #
    # @return [true] If parameters are equal in structure and values.
    #
    # @return [false] If parameters are not equal in structure and values.
    def deep_equal?(struct1, struct2)
      if struct1.eql?(struct2)
        case struct1
        when Array
          struct1.zip(struct2).each { |e1, e2| deep_equal?(e1, e2) }
        when Hash
          struct1.merge(struct2).each { |v1, v2| deep_equal?(v1, v2) }
        else
          true
        end
      else
        false
      end
    end

    ##
    # Returns a hash or array with all hash keys modified by the passed block.
    #
    # @param structure [Hash, Array] The hash or array to transform the keys.
    #
    # @yield [&block] Operation to modify the keys.
    #
    # @return [Hash, Array] The hash or array with transformed keys.
    def deep_transform_keys(structure, &block)
      case structure
      when Hash
        structure.each_with_object({}) do |(k, v), result|
          result[yield(k)] = deep_transform_keys(v, &block)
        end
      when Array
        structure.map { |e| deep_transform_keys(e, &block) }
      else
        structure
      end
    end

    ##
    # Returns a hash or array with all hash values modified by the passed block.
    #
    # @param structure [Hash, Array] The hash or array to transform the values.
    #
    # @yield [&block] Operation to modify the values.
    #
    # @return [Hash, Array] The hash or array with transformed values.
    def deep_transform_values(structure, &block)
      case structure
      when Hash
        structure.transform_values { |v| deep_transform_values(v, &block) }
      when Array
        structure.map { |e| deep_transform_values(e, &block) }
      else
        yield(structure)
      end
    end

    ##
    # Returns a hash or array with all hash keys converted to strings.
    #
    # @param structure [Hash, Array] The hash or array to stringify the keys
    #
    # @return [Hash, Array] The hash or array with stringified keys.
    def deep_stringify_keys(structure)
      deep_transform_keys(structure, &:to_s)
    end

    ##
    # Returns a hash or array with all hash keys converted to symbols.
    #
    # @param structure [Hash, Array] The hash or array to symbolize the keys
    #
    # @return [Hash, Array] The hash or array with symbolized keys.
    def deep_symbolize_keys(structure)
      deep_transform_keys(structure, &:to_sym)
    end
  end
end

##
# The native Hash Ruby class with monkey patched helper methods.
class Hash
  include DeepNest::Helpers
end

##
# The native Array Ruby class with monkey patched helper methods.
class Array
  include DeepNest::Helpers
end
