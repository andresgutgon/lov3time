# frozen_string_literal: true

require 'rails_helper'

describe '#list' do
  let(:is_confirmed) { false }
  let(:search_range_in_km) { nil }
  let(:frank_lonlat) do
    # Plaza Catalunya
    'POINT(2.170041 41.387022)'
  end
  let(:frank) do
    create(
      :person,
      :straight_man,
      :confirmed,
      is_confirmed:,
      lonlat: frank_lonlat,
      search_range_in_km:
    )
  end
  let(:user) { frank.user }

  let(:action) { get '/api/people', headers: jsonapi_headers }

  it_behaves_like 'unauthorized', :user

  context 'when logged and confirmed' do
    let(:is_confirmed) { true }
    # List of people
    let(:clara_confirmed) { true }
    let(:lonlat) do
      # Valencia
      'POINT(-0.376335 39.469707)'
    end
    let!(:maria) { nil }
    let!(:jessica) { nil }
    let!(:clara) do
      create(
        :person,
        :straight_woman,
        :confirmed,
        is_confirmed: clara_confirmed,
        lonlat:,
        name: 'Clara'
      )
    end

    let(:user) { frank.user }

    api_sign_in(:user)

    before { action }

    it 'returns a success status' do
      expect(response).to have_http_status(:success)
    end

    it 'sets json api type' do
      expect(json_body['data'].first).to have_type('person')
    end

    it 'gets meta' do
      expect(json_body).to have_meta(
        total: 1,
        pagination: { current: 1, records: 1 }
      )
    end

    it 'excludes ifself from the list' do
      expect(json_body['data'].size).to be(1)
    end

    # Important to don't look empty when this
    # get started. They always wil be able to change distance range filter of course.
    it 'returns a list of people within default distance range (10.000 km)' do
      clara_response = json_body['data'].first
      expect(clara_response).to have_attribute(:name).with_value(clara.name)
      expect(clara_response).to have_attribute(:birthday).with_value(clara.birthday.as_json)
    end

    context "when frank's location is not set" do
      let(:frank_lonlat) { nil }

      it_behaves_like 'empty_collection'
    end

    context "when Clara's location is not set" do
      let(:lonlat) { nil }

      it_behaves_like 'empty_collection'
    end

    context 'when clara is not confirmed' do
      let(:clara_confirmed) { false }

      it_behaves_like 'empty_collection'
    end

    context 'when frank sets a smaller search range' do
      let(:search_range_in_km) { 50 }

      it_behaves_like 'empty_collection'

      context 'when clara moves near frank' do
        let(:lonlat) do
          # L'Hospitalet de Llobregat
          'POINT(2.099574 41.359592)'
        end

        it 'clara is a possible match' do
          expect(json_body['data'].size).to eq(1)
        end

        it 'calculates distance between current user and people' do
          expect(json_body['data'].first)
            .to have_attribute(:distance_in_km)
            .with_value(6.6)
        end

        context 'when more than one person in the list' do
          let!(:maria) do
            create(
              :person,
              :straight_woman,
              :confirmed,
              # Plaza Universitat
              lonlat: 'POINT(2.1649662 41.3864746)',
              name: 'Maria'
            )
          end
          let!(:jessica) do
            create(
              :person,
              :straight_woman,
              :confirmed,
              # Badalona
              lonlat: 'POINT(2.2482836 41.4433835)',
              name: 'Jessica'
            )
          end
          let(:people) do
            json_body['data'].map do |person|
              {
                name: person.dig('attributes', 'name'),
                distance_in_km: person.dig('attributes', 'distance_in_km')
              }
            end
          end

          it 'sort by distance' do
            expect(people).to eq([
              { name: 'Maria', distance_in_km: 0.4 },
              { name: 'Clara', distance_in_km: 6.6 },
              { name: 'Jessica', distance_in_km: 9.1 }
            ])
          end
        end
      end
    end
  end
end
