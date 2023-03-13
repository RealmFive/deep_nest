# frozen_string_literal: true

require_relative '../deep_nest'

module DeepNest
  module Helpers
    def deep_dup
      DeepNest.deep_dup(self)
    end

    def deep_merge(other_hash, &block)
      DeepNest.deep_merge(self, other_hash, &block)
    end

    def deep_equal?(other_structure)
      DeepNest.deep_equal?(self, other_structure)
    end

    def deep_transform_keys(&block)
      DeepNest.deep_transform_keys(self, &block)
    end

    def deep_transform_values(&block)
      DeepNest.deep_transform_values(self, &block)
    end

    def deep_stringify_keys
      DeepNest.deep_stringify_keys(self)
    end

    def deep_symbolize_keys
      DeepNest.deep_symbolize_keys(self)
    end
  end
end
