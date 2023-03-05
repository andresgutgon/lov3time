# frozen_string_literal: true

require 'rails_helper'

describe '#validate_token' do
  let(:action) { get '/api/auth/validate_token' }

  it 'responds with unauthorized' do
    action
    expect(response).to have_http_status(:unauthorized)
  end

  describe 'when log in' do
    let(:user) { create(:user) }

    api_sign_in(:user)

    it 'gets the token' do
      action
      expect(response).to have_http_status(:success)
    end
  end
end
