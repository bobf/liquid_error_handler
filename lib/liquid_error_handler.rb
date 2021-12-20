# frozen_string_literal: true

require 'liquid'

require_relative 'liquid_error_handler/version'
require_relative 'liquid_error_handler/context'

# Configures Liquid error handlers.
module LiquidErrorHandler
  class Error < StandardError; end

  @hooks = []

  def self.reset
    @hooks = []
  end

  def self.register_handler(&block)
    @hooks << block
  end

  def self.disabled?
    ENV.key?('LIQUID_ERROR_HANDLER_DISABLE')
  end

  class << self
    attr_reader :hooks
  end
end

Liquid::Context.prepend LiquidErrorHandler::Context unless LiquidErrorHandler.disabled?
