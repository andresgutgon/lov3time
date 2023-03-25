# frozen_string_literal: true

module People
  module WithAge
    extend ActiveSupport::Concern

    LEGAL_AGE = 18
    AGE_RANGE_MARGIN = 6.months
    CHANGE_BIRTHDAY_SPAM = 1.month

    class_methods do
      # Convert a number like `45` in a date
      # in SQL. This is helpful for comparing
      # `min_age` from today with the birthday day
      # of the person looking at the list of possible
      # matches
      def years_ago_beggining_of_year(column)
        %{
          date_trunc(
            'year', date '#{Person.today_sql}' + interval '-1 year' *
            #{column}
          )
        }.squish
      end

      def years_ago_end_of_year(column)
        %(
          #{years_ago_beggining_of_year(column)} + INTERVAL '1 year - 1 day'
        ).squish
      end

      def today_sql
        Time.zone.today.strftime('%Y-%m-%d')
      end

      def with_invalid_age_sql
        p = Person.arel_table
        p[:birthday]
          .eq(nil)
          .or(
            p[:min_age].eq(nil).or(p[:max_age].eq(nil))
          )
      end
    end

    included do
      scope :with_age, lambda { |person|
        return Person.none if person.age_range_sql.nil?

        birthday = person.birthday
        desired_age_range = person.age_range_sql
        min_age = Person.years_ago_beggining_of_year('min_age')
        max_age = Person.years_ago_end_of_year('max_age')

        where
          .not(Person.with_invalid_age_sql)
          .where(birthday: desired_age_range)
          .where("#{min_age} >= :birthday", birthday:)
          .where("#{max_age} <= :birthday", birthday:)
      }

      # Validations
      validates(
        :min_age,
        comparison: {
          less_than_or_equal_to: :max_age
        },
        allow_nil: true,
        unless: proc { |p| p.max_age.blank? }
      )

      def age_ready?
        age.present? &&
          age >= LEGAL_AGE &&
          min_age.present? &&
          max_age.present?
      end

      def age
        return nil if birthday.nil?

        (today_to_i - birthday_to_i) / 10_000
      end

      def age_range_sql
        return nil if max_age_date.nil? || min_age_date.nil?

        max_age_date..min_age_date
      end

      def max_age_date
        safe_age(max_age, begging_of_range: true)
      end

      def min_age_date
        safe_age(min_age)
      end

      private

      # Take into account legal age (18) and add a margin
      # to the beggining and end of the range in case someone is
      # just there. Ex.: Someone looking for people 29-32 and one person
      # has 32 and 6 months.
      #
      # @param age_in_years [Maybe<Integer>]
      # @param begging_of_range [Boolean]
      # @return [Maybe<Integer>]
      def safe_age(age_in_years, begging_of_range: false)
        return nil if age_in_years.nil?

        years_ago = age_in_years.years.ago
        under_age = years_ago - AGE_RANGE_MARGIN < LEGAL_AGE

        return legal_age_beggining_of_year if under_age && begging_of_range
        return legal_age_end_of_year if under_age

        return years_ago.beginning_of_year - AGE_RANGE_MARGIN if begging_of_range

        years_ago.end_of_year + AGE_RANGE_MARGIN
      end

      def legal_age_beggining_of_year
        LEGAL_AGE.years.ago.beginning_of_year
      end

      def legal_age_end_of_year
        LEGAL_AGE.years.ago.end_of_year
      end

      def today_to_i
        Time.zone.today.strftime('%Y%m%d').to_i
      end

      def birthday_to_i
        birthday.strftime('%Y%m%d').to_i
      end
    end
  end
end
