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

    trait :with_age_range_30_40 do
      min_age { 30 }
      max_age { 40 }
    end

    trait :with_age_range_30_50 do
      min_age { 30 }
      max_age { 50 }
    end

    trait :with_44_years do
      birthday { Date.new(1978, 10, 10) }
    end

    trait :straight_man do
      name { Faker::Name.male_first_name }
      gender { 'man' }
      gender_preference { %w[woman] }
    end

    trait :from_plaza_catalunya_in_a_50_km_area do
      lonlat { 'POINT(2.170041 41.387022)' }
      search_range_in_km { 50 }
    end

    trait :from_badalona_in_a_50_km_area do
      lonlat { 'POINT(2.2482836 41.4433835)' }
      search_range_in_km { 50 }
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
