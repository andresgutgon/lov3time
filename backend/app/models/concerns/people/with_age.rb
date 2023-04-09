# frozen_string_literal: true

module People
  module WithAge
    extend ActiveSupport::Concern

    LEGAL_AGE = 18
    AGE_RANGE_MARGIN_STR = '6 month'
    AGE_RANGE_MARGIN = 6.months
    CHANGE_BIRTHDAY_SPAM = 2.weeks

    class_methods do
      # Convert a number like `45` in a date
      # in SQL. This is helpful for comparing
      # `min_age` from today with the birthday day
      # of the person looking at the list of possible
      # matches
      def years_in_the_past(column, time_interval: nil)
        sql = %{
          date_trunc('year', date '#{Person.today_sql}' + interval '-1 year' * #{column})
        }.squish
        return sql if time_interval.nil?

        "#{sql} + '- #{time_interval}'"
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
        min_age = Person.years_in_the_past('min_age')
        max_age = Person.years_in_the_past('max_age', time_interval: AGE_RANGE_MARGIN_STR)

        where
          .not(Person.with_invalid_age_sql)
          .where(birthday: desired_age_range)
          .where("#{min_age} >= :birthday", birthday:)
          .where("#{max_age} <= :birthday", birthday:)
      }

      # Validations
      validates(
        :min_age,
        comparison: { less_than_or_equal_to: :max_age },
        allow_nil: true,
        unless: proc { |p| p.max_age.blank? }
      )
      validate :over_legal_age?
      validate :can_change_birthday

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
        safe_age(max_age, is_max_age: true)
      end

      def min_age_date
        safe_age(min_age)
      end

      private

      def over_legal_age?
        return if birthday.nil?
        return if age >= LEGAL_AGE

        errors.add(:birthday, :under_legal_age)
      end

      def can_change_birthday
        return if birthday_setup_at.nil?
        return if birthday_setup_at + CHANGE_BIRTHDAY_SPAM > Time.zone.now

        errors.add(:birthday, :birthday_freeze)
      end

      # Take into account legal age (18) and add a margin
      # to the beggining and end of the range in case someone is
      # just there. Ex.: Someone looking for people 29-32 and one person
      # has 32 and 6 months.
      #
      # @param age_in_years [Maybe<Integer>]
      # @param is_max_age [Boolean]
      # @return [Maybe<Integer>]
      def safe_age(age_in_years, is_max_age: false)
        return nil if age_in_years.nil?

        years_ago = age_in_years.years.ago
        under_age = years_ago - AGE_RANGE_MARGIN < LEGAL_AGE

        return legal_age_beggining_of_year if under_age && is_max_age
        return legal_age_end_of_year if under_age

        return years_ago.beginning_of_year - AGE_RANGE_MARGIN if is_max_age

        years_ago.beginning_of_year
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
