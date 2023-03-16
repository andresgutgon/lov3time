# frozen_string_literal: true

class PersonSerializer < BaseSerializer
  attributes :name, :birthday

  # Ex.: 6.6 km
  attribute :distance_in_km do |object|
    (object.distance_in_meters / 1000).round(1)
  end
end
