# LiquidErrorHandler

Configure error handling hooks for the [Liquid](https://shopify.github.io/liquid/) templating language for [Ruby](https://www.ruby-lang.org/en/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'liquid_error_handler', '~> 0.1.0'
```

## Usage

Register an error handler, for example in a _Rails_ initializer. Error handlers should be callable and will receive the error as an argument.

```ruby
# config/initializers/liquid_error_handler.rb

LiquidErrorHandler.register_handler do |error|
  Rails.logger.error("Liquid Error: #{error} #{error.backtrace}")
end
```

Use with libraries like [Airbrake](https://github.com/airbrake/airbrake) to send all _Liquid_ errors to your error aggregation platform:

```ruby
# config/initializers/liquid_error_handler.rb

LiquidErrorHandler.register_handler do |error|
  Airbrake.notify(error) unless Rails.env.development? || Rails.env.test?
end
```

### Disabling

_LiquidErrorHandler_ can be disabled by setting the environment variable `LIQUID_ERROR_HANDLER_DISABLE` to any value:

```console
LIQUID_ERROR_HANDLER_DISABLE=1 rails server
```

### Resetting

All error handlers can be removed by calling `LiquidErrorHandler.reset`:

```ruby
LiquidErrorHandler.reset
```

## License

[MIT License](LICENSE)
