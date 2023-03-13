# frozen_string_literal: true

require_relative 'deep_nest/helpers'
require_relative 'deep_nest/version'

##
# Primary namespace for the deep_nest gem.
module DeepNest
  ##
  # Default error class for DeepNest.
  class Error < StandardError; end
end

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
