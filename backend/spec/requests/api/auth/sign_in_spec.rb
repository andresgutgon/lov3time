# frozen_string_literal: true

require 'rails_helper'

describe '#sign_in' do
  let(:is_confirmed) { true }
  let(:user) { create(:user, :confirmed, is_confirmed:) }
  let(:params) do
    {
      email: user.email,
      password: user.password
    }
  end
  let(:action) { post '/api/auth/sign_in', params: }

  before { action }

  it 'successfully login' do
    expect(response).to have_http_status(:success)
    expect(response.body).to include_json(
      data: {
        email: user.email,
        provider: 'email',
        uid: user.email,
        allow_password_change: false
      }
    )
  end

  context 'when user is not confirmed' do
    let(:is_confirmed) { false }

    it 'returns unconfirmed message' do
      expect(response).to have_http_status(:unauthorized)
      expect(response.body).to include_json(
        success: false,
        errors: [
          "A confirmation email was sent to your account at '#{user.email}'. " \
          'You must follow the instructions in the email before your account can be activated'
        ]
      )
    end
  end
end
