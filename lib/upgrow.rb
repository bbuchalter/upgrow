# frozen_string_literal: true

require 'active_model'

require_relative 'upgrow/action'
require_relative 'upgrow/immutable_object'
require_relative 'upgrow/immutable_struct'
require_relative 'upgrow/input'
require_relative 'upgrow/model'
require_relative 'upgrow/result'

require_relative 'upgrow/rails_extensions/prevent_conditional_validations'

# The gem's main namespace.
module Upgrow
end
