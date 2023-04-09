# frozen_string_literal: true

require 'rails_helper'

describe '#list_by_age' do
  let(:search_range_in_km) { nil }
  let(:frank_birthday) { Date.new(1980, 11, 4) }
  let(:frank_min_age) { 30 }
  let(:frank_max_age) { 44 }
  let(:validate) { true }
  let(:frank) do
    person = build(
      :person,
      :straight_man,
      :from_plaza_catalunya_in_a_50_km_area,
      name: 'Frank',
      birthday: frank_birthday,
      min_age: frank_min_age,
      max_age: frank_max_age
    )
    person.save!(validate:)
    person.user.confirm
    person
  end
  let(:user) { frank.user }
  let(:action) { get '/api/people', headers: jsonapi_headers }

  let(:clara_birthday) { Date.new(1978, 10, 10) }
  let(:clara_min_age) { 30 }
  let(:clara_max_age) { 50 }
  let!(:clara) do
    person = build(
      :person,
      :straight_woman,
      :from_badalona_in_a_50_km_area,
      name: 'Clara',
      birthday: clara_birthday,
      min_age: clara_min_age,
      max_age: clara_max_age
    )
    person.save!(validate:)
    person.user.confirm
    person
  end

  api_sign_in(:user)

  before do
    Timecop.freeze(Time.zone.local(2023, 3, 25))
    action
  end

  after { Timecop.return }

  it_behaves_like 'collection_with_one'

  it 'display age attributes' do
    clara_response = json_body['data'].first

    expect(clara_response)
      .to have_attribute(:age).with_value(44)
  end

  describe 'when Frank does not have birthday' do
    let(:frank_birthday) { nil }

    it_behaves_like 'empty_collection'
  end

  describe 'when Frank is under 18' do
    # Imagine we don't have validation in place
    let(:validate) { false }
    let(:frank_birthday) { Date.new(2005, 3, 26) }

    it_behaves_like 'empty_collection'
  end

  describe 'when Frank did not setup min age range' do
    let(:frank_min_age) { nil }

    it_behaves_like 'empty_collection'
  end

  describe 'when Frank did not setup max age range' do
    let(:frank_max_age) { nil }

    it_behaves_like 'empty_collection'
  end

  describe 'when Clara does not have birthday' do
    let(:clara_birthday) { nil }

    it_behaves_like 'empty_collection'
  end

  describe 'when Clara is under 18' do
    # Simulate we don't have age validation
    let(:validate) { false }
    let(:frank_min_age) { 18 }
    let(:clara_birthday) { Date.new(2006, 3, 25) + Person::AGE_RANGE_MARGIN }

    it_behaves_like 'empty_collection'
  end

  describe 'when Clara did not setup min age range' do
    let(:clara_min_age) { nil }

    it_behaves_like 'empty_collection'
  end

  describe 'when Clara did not setup max age range' do
    let(:clara_max_age) { nil }

    it_behaves_like 'empty_collection'
  end

  describe 'when Frank wants people older than Clara' do
    # Clara has 44 years. She was born in 1978
    # And frank wants people older than 45 but because
    # we pick 45.years.ago.beginning_of_year it will include
    # Clara. To make the test pass we set 46.
    let(:frank_min_age) { 46 }
    let(:frank_max_age) { 48 }

    it_behaves_like 'empty_collection'
  end

  describe 'when Frank wants people younger than Clara' do
    let(:frank_max_age) { 40 }

    it_behaves_like 'empty_collection'
  end

  describe 'when Clara wants people older than Frank' do
    let(:clara_min_age) { 43 }

    it_behaves_like 'empty_collection'
  end

  describe 'when Clara wants people younger than Frank' do
    let(:clara_max_age) { 38 }

    it_behaves_like 'empty_collection'
  end

  describe "when Clara is in the upper limit of Frank's age range (+6 months)" do
    let(:clara_birthday) { Date.new(1978, 7, 1) }

    it_behaves_like 'collection_with_one'
  end
end
