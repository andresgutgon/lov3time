# frozen_string_literal: true

require 'jsonapi/rspec'
require_relative './requests/json_api'

RSpec.configure do |config|
  config.include JSONAPI::RSpec
  config.include Requests::JsonApi::Helpers

  # Support for documents with mixed string/symbol keys.
  # Disabled by default.
  config.jsonapi_indifferent_hash = true
end
