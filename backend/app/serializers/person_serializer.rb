# frozen_string_literal: true

class PersonSerializer < BaseSerializer
  attributes(
    :name,
    :birthday,
    :gender_visible,
    :sexuality_visible,
    :age
  )

  attribute :gender, &:humanized_gender
  attribute :sexuality, &:humanized_sexuality

  # Ex.: 6.6 km
  attribute :distance_in_km do |object|
    (object.distance_in_meters / 1000).round(1)
  end
end
