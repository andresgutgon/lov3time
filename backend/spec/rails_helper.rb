# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'rspec/rails'
require 'spec_helper'

# Dependencies
require 'devise'
require 'factory_bot_rails'
require 'rspec/json_expectations'
require 'database_cleaner'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Pending migrations check
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  # Includes
  config.include FactoryBot::Syntax::Methods
  config.include(
    Requests::DeviseTokenAuthHelpers::Includables,
    type: :request
  )
  config.extend(
    Requests::DeviseTokenAuthHelpers::Extensions,
    type: :request
  )

  # Configs
  config.run_all_when_everything_filtered = true
  config.filter_run focus: true
  config.fixture_path = Rails.root.join('spec/fixtures')
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.use_transactional_fixtures = false

  # DatabaseCleaner
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
  end

  config.around do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
