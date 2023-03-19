# frozen_string_literal: true

module People
  module WithUser
    extend ActiveSupport::Concern

    included do
      belongs_to :user

      scope :without_user, lambda { |user|
        where.not(user:)
      }
      scope :with_confirmed_users, lambda {
        includes(:user)
          .where
          .not(user: { confirmed_at: nil })
      }
    end
  end
end
