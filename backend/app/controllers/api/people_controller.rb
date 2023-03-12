# frozen_string_literal: true

module Api
  class PeopleController < ApplicationController
    def index
      jsonapi_paginate(collection) do |paginated|
        render jsonapi: paginated
      end
    end

    private

    def collection
      # TODO: Move to a `RecommendedPeopleCollection`
      # This will filter by:
      # 1. GEO location
      # 2. Gender preferences (study!)
      Person.without_user(current_user)
    end
  end
end
