# frozen_string_literal: true

class PeopleRepository < BaseRepository
  def scope
    return Person.none if current_user.person&.lonlat.nil?

    people.select(
      Arel.star,
      person.distance_in_meters_field
    ).order(distance_in_meters: :asc)
  end

  private

  def people
    Person
      .without_user(current_user)
      .confirmed
      .within_person_range(person)
  end

  def person
    @person ||= current_user.person
  end
end
