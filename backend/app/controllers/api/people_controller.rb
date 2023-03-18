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
      @collection ||= PeopleRepository.new(current_user).scope
    end
  end
end
