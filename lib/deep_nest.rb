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
