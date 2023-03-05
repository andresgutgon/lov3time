# frozen_string_literal: true

# typed: false

RSpec.shared_context 'when no_transaction' do
  # NOTE: By default all tests run within transactions that are rolled back
  # at the end of each test. This is not good for this test since business
  # logic is starting a new db connection within the test and it needs to
  # be able to query whatever has been persisted in the db. So we
  # temporarily disable this behaviour.
  before(:all) { DatabaseCleaner.strategy = :truncation }

  after { DatabaseCleaner.clean }

  after(:all) { DatabaseCleaner.strategy = :transaction }
end
