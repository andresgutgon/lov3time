# frozen_string_literal: true

class Person < ApplicationRecord
  belongs_to :user

  # Scopes
  scope :without_user, lambda { |user|
    where.not(user:)
  }
end
