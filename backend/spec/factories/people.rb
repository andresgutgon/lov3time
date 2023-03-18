# typed: false
# frozen_string_literal: true

FactoryBot.define do
  factory :person do
    birthday { Date.new(1998, 3, 3) }
    name { Faker::Name.female_first_name }
    sexuality { 'prefer_not_to_say' }
    user

    trait :straight_woman do
      name { Faker::Name.female_first_name }
      gender { 'woman' }
      gender_preference { %w[man] }
    end

    trait :straight_man do
      name { Faker::Name.male_first_name }
      gender { 'man' }
      gender_preference { %w[woman] }
    end

    trait :confirmed do
      transient do
        is_confirmed { true }
      end
      after(:create) do |person, evaluator|
        person.user.confirm if evaluator.is_confirmed
      end
    end
  end
end
