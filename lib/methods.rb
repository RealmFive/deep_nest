# frozen_string_literal: true

require_relative 'deep_nest/helpers'

class Hash
  include DeepNest::Helpers
end

class Array
  include DeepNest::Helpers
end

class String
  include DeepNest::Helpers
end

class Numeric
  include DeepNest::Helpers
end

class TrueClass
  include DeepNest::Helpers
end

class FalseClass
  include DeepNest::Helpers
end
