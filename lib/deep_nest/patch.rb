# frozen_string_literal: true

require_relative 'helpers'

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
