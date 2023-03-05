# frozen_string_literal: true

require 'rails_helper'

describe '#sign_out' do
  let(:user) { create(:user) }
  let(:action) { delete '/api/auth/sign_out' }

  api_sign_in(:user)

  before { action }

  it 'successfully logout' do
    expect(response).to have_http_status(:success)
  end
end
