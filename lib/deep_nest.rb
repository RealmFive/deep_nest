# frozen_string_literal: true

require_relative "deep_nest/version"

##
# Primary namespace for the deep_nest gem.
module DeepNest
  class Error < StandardError; end
  class << self
    ##
    # Returns a deep copy of the passed hash or array
    #
    # @param structure [Hash, Array] The hash or array to be deep copied.
    #
    # @return [obj] The deep copy of the passed hash or array.
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
    # Returns true if the passed objects are the same object, false otherwise.
    #
    # @param obj1 [Object] First object to be compared.
    #
    # @param obj2 [Object] Second object to be compared.
    #
    # @return [true] If passed objects are the same object.
    #
    # @return [false] If passed objects are not the same object.
    def deep_equal?(obj1, obj2)
      obj1.object_id == obj2.object_id
    end

    ##
    # Returns a hash with its keys modified by the passed block.
    #
    # @param hash [Hash] The hash to transform its keys.
    #
    # @yield [&block] Operation to modify hash's keys.
    #
    # @return [Hash] The hash with transformed keys.
    def deep_transform_keys(hash, &block)
      case hash
      when Hash
        hash.each_with_object({}) do |(k, v), result|
          result[yield(k)] = deep_transform_keys(v, &block)
        end
      when Array
        hash.map { |e| deep_transform_keys(e, &block) }
      else
        hash
      end
    end

    ##
    # Returns a hash with its values modified by the passed block.
    #
    # @param hash [Hash] The hash to transform its values.
    #
    # @yield [&block] Operation to modify hash's values.
    #
    # @return [Hash] The hash with transformed values.
    def deep_transform_values(hash, &block)
      case hash
      when Hash
        hash.transform_values { |v| deep_transform_values(v, &block) }
      when Array
        hash.map { |e| deep_transform_values(e, &block) }
      else
        yield(hash)
      end
    end

    ##
    # Returns a hash with its keys converted to strings.
    #
    # @param hash [Hash] The hash to stringify its keys.
    #
    # @return [Hash] The transformed hash with stringiified keys.
    def deep_stringify_keys(hash)
      deep_transform_keys(hash, &:to_s)
    end

    ##
    # Returns a hash with its keys converted to symbols.
    #
    # @param hash [Hash] The hash to symbolize its keys.
    #
    # @return [Hash] The transformed hash with symbolized keys.
    def deep_symbolize_keys(hash)
      deep_transform_keys(hash, &:to_sym)
    end
  end
end
