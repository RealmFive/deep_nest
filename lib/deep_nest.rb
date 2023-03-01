# frozen_string_literal: true

require_relative "deep_nest/version"

module DeepNest
  class << self
    def deep_dup(obj)
      case obj
      when Array
        obj.map { |x| deep_dup(x) }
      when Hash
        obj.transform_values { |v| deep_dup(v) }
      else
        obj
      end
    end

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

    def deep_equal?(obj1, obj2)
      obj1.object_id == obj2.object_id
    end

    def deep_transform_keys(obj, &block)
      case obj
      when Hash
        obj.each_with_object({}) do |(k, v), result|
          result[yield(k)] = deep_transform_keys(v, &block)
        end
      when Array
        obj.map { |e| deep_transform_keys(e, &block) }
      else
        obj
      end
    end

    def deep_transform_values(obj, &block)
      case obj
      when Hash
        obj.transform_values { |v| deep_transform_values(v, &block) }
      when Array
        obj.map { |e| deep_transform_values(e, &block) }
      else
        yield(obj)
      end
    end

    def deep_stringify_keys(obj)
      deep_transform_keys(obj, &:to_s)
    end

    def deep_stringify_values(obj)
      deep_transform_values(obj, &:to_s)
    end
  end
end
