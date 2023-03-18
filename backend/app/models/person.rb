# frozen_string_literal: true

class Person < ApplicationRecord
  include People::WithUser
  include People::WithLocation
  include People::WithGender
  include People::WithSexuality

  def ready_to_love?
    lonlat.present? &&
      gender.present? &&
      gender_preference.present?
  end
end
