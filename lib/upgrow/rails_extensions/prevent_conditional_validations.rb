# frozen_string_literal: true

module Upgrow
  module RailsExtensions
    class ConditionalValidationsNotPermitted < StandardError
    end

    # Rails provides for conditional validations by accepting the `on`
    # parameter to the validation macro.
    # See https://github.com/rails/rails/blob/main/activemodel/lib/active_model/validations.rb#L72-L73
    # Because we want inputs to be backed by ActiveModel, but also immutable,
    # we can't support conditional validations. Removing conditional validations
    # aligns nicely with the Upgrow patterns anyway, so this is a clear win.
    module PreventConditionalValidations
      private

      # Raise when conditional validations are used as part of Upgrow.
      def validation_context=(context)
        raise ConditionalValidationsNotPermitted if context
      end
    end
  end
end

Upgrow::Input.prepend(Upgrow::RailsExtensions::PreventConditionalValidations)
