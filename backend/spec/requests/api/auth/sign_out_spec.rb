# frozen_string_literal: true

require 'rails_helper'

describe '#sign_out', type: :request do
  let(:user) { create(:user) }
  api_sign_in(:user)
  let(:action) { delete '/api/auth/sign_out' }

  before { action }

  it 'successfully logout' do
    expect(response).to have_http_status(:success)
  end
end
