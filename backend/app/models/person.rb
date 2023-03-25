# frozen_string_literal: true

class Person < ApplicationRecord
  include People::WithUser
  include People::WithLocation
  include People::WithGender
  include People::WithSexuality
  include People::WithAge

  def ready_to_love?
    lonlat.present? &&
      gender_ready? &&
      age_ready?
  end
end
