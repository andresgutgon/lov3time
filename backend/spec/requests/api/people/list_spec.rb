# frozen_string_literal: true

require 'rails_helper'

describe '#list' do
  let(:is_confirmed) { false }
  let(:frank) do
    create(
      :person,
      :man,
      :confirmed,
      is_confirmed:
    )
  end
  let(:user) { frank.user }

  let(:action) { get '/api/people', headers: jsonapi_headers }

  it_behaves_like 'unauthorized', :user

  context 'when logged and confirmed' do
    let(:is_confirmed) { true }
    # List of people
    let(:clara_confirmed) { true }
    let!(:clara) do
      create(
        :person,
        :woman,
        :confirmed,
        is_confirmed: clara_confirmed
      )
    end

    let(:user) { frank.user }

    api_sign_in(:user)

    before { action }

    it 'returns a siccess status' do
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

    it 'returns a list of people' do
      clara_response = json_body['data'].first
      expect(clara_response).to have_attribute(:name).with_value(clara.name)
      expect(clara_response).to have_attribute(:birthday).with_value(clara.birthday.as_json)
    end
  end
end
