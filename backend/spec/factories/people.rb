# typed: false
# frozen_string_literal: true

FactoryBot.define do
  factory :person do
    birthday { Date.new(1998, 3, 3) }
    user

    trait :woman do
      name { Faker::Name.female_first_name }
    end

    trait :man do
      name { Faker::Name.male_first_name }
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
