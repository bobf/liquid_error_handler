# frozen_string_literal: true

require 'liquid_error_handler'

require 'devpack'
require 'rspec/file_fixtures'

Dir[File.join(__dir__, 'support', '*.rb')].sort.each { |path| require path }

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
