# frozen_string_literal: true

require_relative 'methods'

##
# Namespace for helper methods to use self in recursive methods
module DeepNest
  ##
  # Default error class for Methods module.
  class Error < StandardError; end

  module Helpers
    ##
    # Returns a deep copy of the passed hash or array.
    #
    # @param self [Hash, Array] The hash or array to be deep copied.
    #
    # @return [Hash, Array] The deep copy of the passed hash or array.
    def deep_dup
      DeepNest::Methods.deep_dup(self)
    end

    ##
    # Returns a hash with the passed hashes recursively merged. An optional block can be passed to merge values.
    #
    # @param self [Hash] The first hash to be merged.
    #
    # @param other_hash [Hash] The second hash to be merged.
    #
    # @yield [&block] Operation to merge values of the hashes.
    #
    # @return [Hash] The hash with recursively merged hashes.
    def deep_merge(other_hash, &block)
      DeepNest::Methods.deep_merge(self, other_hash, &block)
    end

    ##
    # Returns true if the passed parameters are same in structure and values, false otherwise.
    #
    # @param self [Hash, Array] First structure to be compared.
    #
    # @param other_structure [Hash, Array] Second structure to be compared.
    #
    # @return [true] If parameters are equal in structure and values.
    #
    # @return [false] If parameters are not equal in structure and values.
    def deep_equal?(other_structure)
      DeepNest::Methods.deep_equal?(self, other_structure)
    end

    ##
    # Returns a hash or array with all hash keys modified by the passed block.
    #
    # @param self [Hash, Array] The hash or array to transform the keys.
    #
    # @yield [&block] Operation to modify the keys.
    #
    # @return [Hash, Array] The hash or array with transformed keys.
    def deep_transform_keys(&block)
      DeepNest::Methods.deep_transform_keys(self, &block)
    end

    ##
    # Returns a hash or array with all hash values modified by the passed block.
    #
    # @param self [Hash, Array] The hash or array to transform the values.
    #
    # @yield [&block] Operation to modify the values.
    #
    # @return [Hash, Array] The hash or array with transformed values.
    def deep_transform_values(&block)
      DeepNest::Methods.deep_transform_values(self, &block)
    end

    ##
    # Returns a hash or array with all hash keys converted to strings.
    #
    # @param self [Hash, Array] The hash or array to stringify the keys
    #
    # @return [Hash, Array] The hash or array with stringified keys.
    def deep_stringify_keys
      DeepNest::Methods.deep_stringify_keys(self)
    end

    ##
    # Returns a hash or array with all hash keys converted to symbols.
    #
    # @param self [Hash, Array] The hash or array to symbolize the keys
    #
    # @return [Hash, Array] The hash or array with symbolized keys.
    def deep_symbolize_keys
      DeepNest::Methods.deep_symbolize_keys(self)
    end
  end
end
