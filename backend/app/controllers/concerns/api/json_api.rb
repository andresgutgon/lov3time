# frozen_string_literal: true

module Api
  # JSONAPI customizations
  # https://github.com/stas/jsonapi.rb
  #
  # The idea is to have all related JSON API gem
  # here.
  module JsonApi
    extend ActiveSupport::Concern

    included do
      # JSONAPI includes
      include JSONAPI::Errors
      include JSONAPI::Pagination

      private

      def render_jsonapi_internal_server_error(exception)
        # TODO: Use Sentry and call it here
        Rails.logger.error(exception)
        super(exception)
      end

      def jsonapi_meta(resources)
        meta = {}
        pagination = jsonapi_pagination_meta(resources)

        meta = meta.merge(total: resources.count) if resources.respond_to?(:count)

        meta = meta.merge(pagination:) if pagination.present?

        meta
      end

      # By default try to use naming conventions
      def jsonapi_serializer_class(resource, is_collection)
        JSONAPI::Rails.serializer_class(resource, is_collection)
      rescue NameError
        klass = resource.class
        klass = resource.first.class if is_collection
        "Custom#{klass.name}Serializer".constantize
      end
    end
  end
end
