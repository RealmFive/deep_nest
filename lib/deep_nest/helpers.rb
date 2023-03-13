# frozen_string_literal: true

require_relative 'methods'

module DeepNest
  module Helpers
    def deep_dup
      DeepNest::Methods.deep_dup(self)
    end

    def deep_merge(other_hash, &block)
      DeepNest::Methods.deep_merge(self, other_hash, &block)
    end

    def deep_equal?(other_structure)
      DeepNest::Methods.deep_equal?(self, other_structure)
    end

    def deep_transform_keys(&block)
      DeepNest::Methods.deep_transform_keys(self, &block)
    end

    def deep_transform_values(&block)
      DeepNest::Methods.deep_transform_values(self, &block)
    end

    def deep_stringify_keys
      DeepNest::Methods.deep_stringify_keys(self)
    end

    def deep_symbolize_keys
      DeepNest::Methods.deep_symbolize_keys(self)
    end
  end
end
