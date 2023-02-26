
# typed: false
# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'papapa44' }

    trait :confirmed do
      transient do
        is_confirmed { true }
      end
      after(:create) do |user, evaluator|
        user.confirm if evaluator.is_confirmed
      end
    end
  end
end
