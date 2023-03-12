# frozen_string_literal: true

module Requests
  module JsonApi
    module Helpers
      # Helper to return JSONAPI valid headers
      #
      # @return [Hash] the relevant content type &co
      def jsonapi_headers
        { 'Content-Type' => Mime[:jsonapi].to_s }
      end

      def json_body
        JSON.parse(response.body)
      end
    end
  end
end
