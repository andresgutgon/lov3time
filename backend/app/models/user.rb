# frozen_string_literal: true

class User < ApplicationRecord
  include DeviseTokenAuth::Concerns::User

  # notice that :omniauthable is not included in this block
  devise(
    :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :validatable,
    :confirmable,
    :trackable
  )

  # Relations
  has_one :person, dependent: :destroy
end
