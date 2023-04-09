# frozen_string_literal: true

require 'rails_helper'

describe '#list_by_gender' do
  let(:search_range_in_km) { nil }
  let(:frank_gender) { 'man' }
  let(:frank_gender_preference) { ['woman'] }
  let(:frank) do
    create(
      :person,
      :confirmed,
      :with_44_years,
      :with_age_range_30_50,
      # Plaza Catalunya
      lonlat: 'POINT(2.170041 41.387022)',
      gender: frank_gender,
      gender_preference: frank_gender_preference,
      search_range_in_km: 50
    )
  end
  let(:user) { frank.user }
  let(:action) { get '/api/people', headers: jsonapi_headers }

  let(:clara_gender) { :woman }
  let(:clara_gender_preference) { ['man'] }

  let!(:clara) do
    create(
      :person,
      :confirmed,
      :with_44_years,
      :with_age_range_30_50,
      # Badalona
      lonlat: 'POINT(2.2482836 41.4433835)',
      name: 'Clara',
      gender: clara_gender,
      gender_preference: clara_gender_preference
    )
  end

  api_sign_in(:user)
  before do
    Timecop.freeze(Time.zone.local(2023, 3, 25))
    action
  end

  it_behaves_like 'collection_with_one'

  it 'display gender attributes' do
    clara_response = json_body['data'].first

    expect(clara_response)
      .to have_attribute(:gender).with_value('Woman')
    expect(clara_response)
      .to have_attribute(:sexuality).with_value('Prefer not to say')
    expect(clara_response)
      .to have_attribute(:gender_visible)
      .with_value(true)
    expect(clara_response)
      .to have_attribute(:sexuality_visible)
      .with_value(true)
  end

  context "when frank's gender preference is not set" do
    let(:frank_gender_preference) { [] }

    it_behaves_like 'empty_collection'
  end

  context "when frank's gender is not set" do
    let(:frank_gender) { nil }

    it_behaves_like 'empty_collection'
  end

  context "when clara's gender is not set" do
    let(:clara_gender) { nil }

    it_behaves_like 'empty_collection'
  end

  context "when clara's gender preference is not set" do
    let(:clara_gender_preference) { [] }

    it_behaves_like 'empty_collection'
  end

  context 'when a Clara wants to date another women' do
    let(:clara_gender_preference) { [:woman] }

    it_behaves_like 'empty_collection'
  end

  context "when clara's is a transgender woman" do
    let(:clara_gender) { :transgender_woman }

    it_behaves_like 'empty_collection'

    context 'when Clara choose everyone' do
      let(:clara_gender_preference) { [Person.everyone] }

      it_behaves_like 'empty_collection'
    end

    context 'when frank choose woman and transgender woman' do
      let(:frank_gender_preference) { %w[woman transgender_woman] }

      it_behaves_like 'collection_with_one'
    end

    context 'when frank choose everyone' do
      let(:frank_gender_preference) { [Person.everyone] }

      it_behaves_like 'collection_with_one'
    end
  end
end
