# frozen_string_literal: true

module LiquidErrorHandler
  # Prepended to Liquid context to handle any errors that take place during render.
  module Context
    def handle_error(error, *_args)
      return super if LiquidErrorHandler.disabled?

      LiquidErrorHandler.hooks.each { |hook| hook.call(error.cause.nil? ? error : error.cause) }
      super
    end
  end
end
