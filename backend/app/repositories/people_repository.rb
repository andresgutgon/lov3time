# frozen_string_literal: true

class PeopleRepository < BaseRepository
  def scope
    return Person.none unless person.ready_to_love?

    people.select(
      Arel.star,
      person.distance_in_meters_field
    ).order(distance_in_meters: :asc)
  end

  private

  def people
    Person
      .without_user(current_user)
      .with_confirmed_users
      .with_location(person)
      .with_gender(person)
      .with_age(person)
  end

  def person
    @person ||= current_user.person
  end
end
