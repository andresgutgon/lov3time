# frozen_string_literal: true

module People
  module WithGender
    extend ActiveSupport::Concern
    GENDER = %w[
      woman
      man
      nonbinary
      transgender_woman
      transgender_man
    ].freeze
    GENDER_EVERYONE = 'everyone'
    GENDER_PREFERENCE = GENDER + [GENDER_EVERYONE]

    class_methods do
      def everyone
        GENDER_EVERYONE
      end

      def all_genders
        @all_genders ||= GENDER
      end

      def all_genders_sql
        @all_genders_sql ||= all_genders.map do |gen|
          "\"#{gen}\""
        end.join(',')
      end

      def people_gender_preference_query
        <<-SQL
          CASE WHEN 'everyone' = ANY(gender_preference)
          THEN gender_preference && :all_genders
          ELSE
          :person_gender = ANY(gender_preference)
          END
        SQL
          .squish
      end
    end

    included do
      assignable_values_for(
        :gender,
        allow_blank: true
      ) do
        GENDER
      end
      assignable_values_for(
        :gender_preference,
        multiple: true,
        allow_blank: true
      ) do
        GENDER_PREFERENCE
      end
      scope :with_gender, lambda { |person|
        where(gender: person.gender_preferences).where(
          Person.people_gender_preference_query,
          person_gender: person.gender,
          all_genders: "{#{Person.all_genders_sql}}"
        )
      }

      def gender_preferences
        return Person.all_genders if gender_preference.include?(Person.everyone)

        gender_preference
      end
    end
  end
end
