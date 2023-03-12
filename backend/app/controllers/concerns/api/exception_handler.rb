# frozen_string_literal: true

module Api
  module ExceptionHandler
    extend ActiveSupport::Concern

    # Some exceptions are already defined in
    # JSONAPI::Errors
    included do
      rescue_from Exceptions::Unauthorized do
        error = { status: '401', title: Rack::Utils::HTTP_STATUS_CODES[401] }
        render jsonapi_errors: [error], status: :unauthorized
      end
    end
  end
end
